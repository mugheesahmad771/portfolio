import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/services/project_service.dart';

class LinkRow {
  final TextEditingController label;
  final TextEditingController url;
  LinkRow({String label = '', String url = ''})
    : label = TextEditingController(text: label),
      url = TextEditingController(text: url);
  void dispose() {
    label.dispose();
    url.dispose();
  }
}

class StatRow {
  final TextEditingController label;
  final TextEditingController value;
  StatRow({String label = '', String value = ''})
    : label = TextEditingController(text: label),
      value = TextEditingController(text: value);
  void dispose() {
    label.dispose();
    value.dispose();
  }
}

/// One row in the Apps editor — a labeled, platform-tagged screenshot
/// gallery for one product within a multi-app project (e.g. "Customer App"
/// on "iOS"). [platform] is a plain mutable field, not `Rx`, because it's
/// only ever changed via [ProjectFormViewModel.setAppPlatform], which
/// refreshes the owning list itself.
class AppRow {
  final TextEditingController label;
  final TextEditingController screenshots;
  String platform;
  AppRow({String label = '', this.platform = 'Web', String screenshots = ''})
    : label = TextEditingController(text: label),
      screenshots = TextEditingController(text: screenshots);
  void dispose() {
    label.dispose();
    screenshots.dispose();
  }
}

const List<String> kAllPlatforms = ['Android', 'iOS', 'Web'];
const List<String> kEmploymentTypes = [
  'Full-time',
  'Contract',
  'Freelance',
  'Personal Project',
];

class ProjectFormViewModel extends GetxController {
  final ProjectService _projectService = Get.find<ProjectService>();

  ProjectModel? _existing;
  bool get isEditing => _existing != null;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final slugController = TextEditingController();
  final companyController = TextEditingController();
  final clientController = TextEditingController();
  final roleController = TextEditingController();
  final durationController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final fullDescriptionController = TextEditingController();
  final problemStatementController = TextEditingController();
  final solutionController = TextEditingController();
  final responsibilitiesController = TextEditingController();
  final keyFeaturesController = TextEditingController();
  final technologiesController = TextEditingController();
  final screenshotsController = TextEditingController();
  final githubLinkController = TextEditingController();
  final liveLinkController = TextEditingController();
  final playStoreUrlController = TextEditingController();
  final appStoreUrlController = TextEditingController();
  final videoUrlController = TextEditingController();

  final _employmentType = kEmploymentTypes.first.obs;
  final _startDate = Rxn<DateTime>();
  final _endDate = Rxn<DateTime>();
  final _currentlyWorking = false.obs;
  final _featured = false.obs;
  final _privateProject = false.obs;
  final _canShowScreenshots = true.obs;
  final _canShowCompanyName = true.obs;
  final _selectedPlatforms = <String>{'Web'}.obs;
  final _thumbnail = Rxn<String>();
  final _coverImage = Rxn<String>();
  final _isUploadingThumbnail = false.obs;
  final _isUploadingCover = false.obs;

  final links = <LinkRow>[].obs;
  final stats = <StatRow>[].obs;
  final apps = <AppRow>[].obs;

  final _isLoading = false.obs;
  final _isSaving = false.obs;
  final _errorMessage = ''.obs;

  String get employmentType => _employmentType.value;
  DateTime? get startDate => _startDate.value;
  DateTime? get endDate => _endDate.value;
  bool get currentlyWorking => _currentlyWorking.value;
  bool get featured => _featured.value;
  bool get privateProject => _privateProject.value;
  bool get canShowScreenshots => _canShowScreenshots.value;
  bool get canShowCompanyName => _canShowCompanyName.value;
  Set<String> get selectedPlatforms => _selectedPlatforms;
  String? get thumbnail => _thumbnail.value;
  String? get coverImage => _coverImage.value;
  bool get isUploadingThumbnail => _isUploadingThumbnail.value;
  bool get isUploadingCover => _isUploadingCover.value;
  bool get isLoading => _isLoading.value;
  bool get isSaving => _isSaving.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    final id = Get.parameters['id'];
    if (id != null && id.isNotEmpty) _load(id);
  }

  Future<void> _load(String id) async {
    _isLoading.value = true;
    update();
    try {
      _existing = await _projectService.getById(id);
      final p = _existing;
      if (p != null) {
        titleController.text = p.title;
        slugController.text = p.slug;
        companyController.text = p.company ?? '';
        clientController.text = p.client ?? '';
        roleController.text = p.role;
        durationController.text = p.duration;
        shortDescriptionController.text = p.shortDescription;
        fullDescriptionController.text = p.fullDescription;
        problemStatementController.text = p.problemStatement;
        solutionController.text = p.solution;
        responsibilitiesController.text = p.responsibilities.join('\n');
        keyFeaturesController.text = p.keyFeatures.join('\n');
        technologiesController.text = p.technologies.join(', ');
        screenshotsController.text = p.screenshots.join('\n');
        githubLinkController.text = p.githubLink ?? '';
        liveLinkController.text = p.liveLink ?? '';
        playStoreUrlController.text = p.playStoreUrl ?? '';
        appStoreUrlController.text = p.appStoreUrl ?? '';
        videoUrlController.text = p.videoUrl ?? '';
        _employmentType.value = kEmploymentTypes.contains(p.employmentType)
            ? p.employmentType
            : kEmploymentTypes.first;
        _startDate.value = p.startDate;
        _endDate.value = p.endDate;
        _currentlyWorking.value = p.currentlyWorking;
        _featured.value = p.featured;
        _privateProject.value = p.privateProject;
        _canShowScreenshots.value = p.canShowScreenshots;
        _canShowCompanyName.value = p.canShowCompanyName;
        _selectedPlatforms
          ..clear()
          ..addAll(p.platforms);
        _thumbnail.value = p.thumbnail;
        _coverImage.value = p.coverImage;
        links.value = p.links
            .map((l) => LinkRow(label: l.label, url: l.url))
            .toList();
        stats.value = p.statistics
            .map((s) => StatRow(label: s.label, value: s.value))
            .toList();
        apps.value = p.apps
            .map(
              (a) => AppRow(
                label: a.label,
                platform: a.platform,
                screenshots: a.screenshots.join('\n'),
              ),
            )
            .toList();
      }
    } catch (_) {
      _errorMessage.value = 'Could not load this project.';
    }
    _isLoading.value = false;
    update();
  }

  void setEmploymentType(String value) => _employmentType.value = value;
  void setCurrentlyWorking(bool value) => _currentlyWorking.value = value;
  void setFeatured(bool value) => _featured.value = value;
  void setPrivateProject(bool value) => _privateProject.value = value;
  void setCanShowScreenshots(bool value) => _canShowScreenshots.value = value;
  void setCanShowCompanyName(bool value) => _canShowCompanyName.value = value;
  void setStartDate(DateTime? d) => _startDate.value = d;
  void setEndDate(DateTime? d) => _endDate.value = d;

  void togglePlatform(String platform, bool selected) {
    if (selected) {
      _selectedPlatforms.add(platform);
    } else {
      _selectedPlatforms.remove(platform);
    }
    _selectedPlatforms.refresh();
  }

  void addLink() => links.add(LinkRow());
  void removeLink(int index) {
    links[index].dispose();
    links.removeAt(index);
  }

  void addStat() => stats.add(StatRow());
  void removeStat(int index) {
    stats[index].dispose();
    stats.removeAt(index);
  }

  void addApp() => apps.add(AppRow());
  void removeApp(int index) {
    apps[index].dispose();
    apps.removeAt(index);
  }

  void setAppPlatform(int index, String platform) {
    apps[index].platform = platform;
    apps.refresh();
  }

  Future<void> pickThumbnail() => _pickAndUpload(isThumbnail: true);
  Future<void> pickCoverImage() => _pickAndUpload(isThumbnail: false);

  Future<void> _pickAndUpload({required bool isThumbnail}) async {
    final files = await FilePicker.pickFiles(type: FileType.image);
    if (files.isEmpty) return;
    final file = files.first;
    final Uint8List bytes = await file.readAsBytes();

    if (isThumbnail) {
      _isUploadingThumbnail.value = true;
    } else {
      _isUploadingCover.value = true;
    }
    update();
    try {
      final url = await _projectService.uploadImage(file.name, bytes);
      if (isThumbnail) {
        _thumbnail.value = url;
      } else {
        _coverImage.value = url;
      }
    } catch (_) {
      _errorMessage.value = 'Image upload failed. Please try again.';
    }
    _isUploadingThumbnail.value = false;
    _isUploadingCover.value = false;
    update();
  }

  Future<bool> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    _isSaving.value = true;
    _errorMessage.value = '';
    update();
    try {
      final project = ProjectModel(
        id: _existing?.id ?? '',
        slug: slugController.text.trim(),
        title: titleController.text.trim(),
        company: companyController.text.trim().isEmpty
            ? null
            : companyController.text.trim(),
        client: clientController.text.trim().isEmpty
            ? null
            : clientController.text.trim(),
        role: roleController.text.trim(),
        employmentType: _employmentType.value,
        duration: durationController.text.trim(),
        startDate: _startDate.value,
        endDate: _endDate.value,
        currentlyWorking: _currentlyWorking.value,
        shortDescription: shortDescriptionController.text.trim(),
        fullDescription: fullDescriptionController.text.trim(),
        problemStatement: problemStatementController.text.trim(),
        solution: solutionController.text.trim(),
        responsibilities: _splitLines(responsibilitiesController.text),
        keyFeatures: _splitLines(keyFeaturesController.text),
        technologies: _splitCsv(technologiesController.text),
        platforms: _selectedPlatforms.isEmpty
            ? ['Web']
            : _selectedPlatforms.toList(),
        screenshots: _splitLines(screenshotsController.text),
        thumbnail: _thumbnail.value,
        coverImage: _coverImage.value,
        videoUrl: _emptyToNull(videoUrlController.text),
        githubLink: _emptyToNull(githubLinkController.text),
        liveLink: _emptyToNull(liveLinkController.text),
        playStoreUrl: _emptyToNull(playStoreUrlController.text),
        appStoreUrl: _emptyToNull(appStoreUrlController.text),
        featured: _featured.value,
        privateProject: _privateProject.value,
        canShowScreenshots: _canShowScreenshots.value,
        canShowCompanyName: _canShowCompanyName.value,
        links: links
            .map(
              (l) => ProjectLink(
                label: l.label.text.trim(),
                url: l.url.text.trim(),
              ),
            )
            .where((l) => l.label.isNotEmpty && l.url.isNotEmpty)
            .toList(),
        statistics: stats
            .map(
              (s) => ProjectStatistic(
                label: s.label.text.trim(),
                value: s.value.text.trim(),
              ),
            )
            .where((s) => s.label.isNotEmpty && s.value.isNotEmpty)
            .toList(),
        apps: apps
            .map(
              (a) => ProjectApp(
                label: a.label.text.trim(),
                platform: a.platform,
                screenshots: _splitLines(a.screenshots.text),
              ),
            )
            .where((a) => a.label.isNotEmpty)
            .toList(),
      );

      if (isEditing) {
        await _projectService.update(project);
      } else {
        await _projectService.create(project);
      }
      _isSaving.value = false;
      update();
      return true;
    } catch (e) {
      _errorMessage.value =
          'Failed to save. Please check your input and try again.';
      _isSaving.value = false;
      update();
      return false;
    }
  }

  List<String> _splitLines(String text) =>
      text.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  List<String> _splitCsv(String text) =>
      text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  String? _emptyToNull(String text) => text.trim().isEmpty ? null : text.trim();

  @override
  void onClose() {
    for (final c in [
      titleController,
      slugController,
      companyController,
      clientController,
      roleController,
      durationController,
      shortDescriptionController,
      fullDescriptionController,
      problemStatementController,
      solutionController,
      responsibilitiesController,
      keyFeaturesController,
      technologiesController,
      screenshotsController,
      githubLinkController,
      liveLinkController,
      playStoreUrlController,
      appStoreUrlController,
      videoUrlController,
    ]) {
      c.dispose();
    }
    for (final l in links) {
      l.dispose();
    }
    for (final s in stats) {
      s.dispose();
    }
    for (final a in apps) {
      a.dispose();
    }
    super.onClose();
  }
}
