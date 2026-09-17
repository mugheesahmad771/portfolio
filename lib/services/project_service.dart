import 'package:get/get.dart';
import 'package:portfolio/core/api_client/client_index.dart';
import 'package:portfolio/core/api_client/main_client.dart';
import 'package:portfolio/core/models/project_model.dart';

/// API-backed, singleton (via [GetxService]) project data source, talking
/// to the backend through the shared [mainClient] Chopper client.
///
/// Every viewmodel shares this ONE instance via `Get.find<ProjectService>()`
/// — that's what makes admin CRUD changes show up everywhere else in the
/// app instead of only within whichever screen made the change.
class ProjectService extends GetxService {
  ProjectModel _fromDto(ProjectDto dto) {
    return ProjectModel(
      id: (dto.id ?? 0).toString(),
      slug: dto.slug ?? '',
      title: dto.title ?? '',
      company: dto.company,
      client: dto.$client,
      role: dto.role ?? '',
      employmentType: dto.employmentType ?? 'Full-time',
      duration: dto.duration ?? '',
      startDate: dto.startDate,
      endDate: dto.endDate,
      currentlyWorking: dto.currentlyWorking ?? false,
      shortDescription: dto.shortDescription ?? '',
      fullDescription: dto.fullDescription ?? '',
      problemStatement: dto.problemStatement ?? '',
      solution: dto.solution ?? '',
      responsibilities: dto.responsibilities ?? const [],
      keyFeatures: dto.keyFeatures ?? const [],
      technologies: dto.technologies ?? const [],
      platforms: dto.platforms ?? const ['Web', 'Mobile'],
      screenshots: dto.screenshots ?? const [],
      thumbnail: dto.thumbnail,
      coverImage: dto.coverImage,
      videoUrl: dto.videoUrl,
      githubLink: dto.githubLink,
      liveLink: dto.liveLink,
      playStoreUrl: dto.playStoreUrl,
      appStoreUrl: dto.appStoreUrl,
      featured: dto.featured ?? false,
      privateProject: dto.privateProject ?? false,
      canShowScreenshots: dto.canShowScreenshots ?? true,
      canShowCompanyName: dto.canShowCompanyName ?? true,
      links: (dto.links ?? const [])
          .map((l) => ProjectLink(label: l.label ?? '', url: l.url ?? ''))
          .toList(),
      statistics: (dto.statistics ?? const [])
          .map(
            (s) =>
                ProjectStatistic(label: s.label ?? '', value: s.$value ?? ''),
          )
          .toList(),
      apps: (dto.apps ?? const [])
          .map(
            (a) => ProjectApp(
              label: a.label ?? '',
              platform: a.platform ?? '',
              screenshots: a.screenshots ?? const [],
            ),
          )
          .toList(),
    );
  }

  CreateProjectRequestModel _toCreateBody(ProjectModel p) {
    return CreateProjectRequestModel(
      slug: p.slug,
      title: p.title,
      company: p.company,
      $client: p.client,
      role: p.role,
      employmentType: p.employmentType,
      duration: p.duration,
      startDate: p.startDate,
      endDate: p.endDate,
      currentlyWorking: p.currentlyWorking,
      shortDescription: p.shortDescription,
      fullDescription: p.fullDescription,
      problemStatement: p.problemStatement,
      solution: p.solution,
      responsibilities: p.responsibilities,
      keyFeatures: p.keyFeatures,
      technologies: p.technologies,
      platforms: p.platforms,
      screenshots: p.screenshots,
      thumbnail: p.thumbnail,
      coverImage: p.coverImage,
      videoUrl: p.videoUrl,
      githubLink: p.githubLink,
      liveLink: p.liveLink,
      playStoreUrl: p.playStoreUrl,
      appStoreUrl: p.appStoreUrl,
      featured: p.featured,
      privateProject: p.privateProject,
      canShowScreenshots: p.canShowScreenshots,
      canShowCompanyName: p.canShowCompanyName,
      links: p.links
          .map((l) => ProjectLinkDto(label: l.label, url: l.url))
          .toList(),
      statistics: p.statistics
          .map((s) => ProjectStatisticDto(label: s.label, $value: s.value))
          .toList(),
      apps: p.apps
          .map(
            (a) => ProjectAppDto(
              label: a.label,
              platform: a.platform,
              screenshots: a.screenshots,
            ),
          )
          .toList(),
    );
  }

  /// Sends the FULL project body on update — every field the edit form
  /// doesn't explicitly set would otherwise be silently reset by the
  /// backend's full-replace semantics (thumbnails, links, statistics,
  /// dates, etc), so this must always carry everything, not a partial diff.
  UpdateProjectRequestModel _toUpdateBody(ProjectModel p) {
    return UpdateProjectRequestModel(
      id: int.tryParse(p.id),
      slug: p.slug,
      title: p.title,
      company: p.company,
      $client: p.client,
      role: p.role,
      employmentType: p.employmentType,
      duration: p.duration,
      startDate: p.startDate,
      endDate: p.endDate,
      currentlyWorking: p.currentlyWorking,
      shortDescription: p.shortDescription,
      fullDescription: p.fullDescription,
      problemStatement: p.problemStatement,
      solution: p.solution,
      responsibilities: p.responsibilities,
      keyFeatures: p.keyFeatures,
      technologies: p.technologies,
      platforms: p.platforms,
      screenshots: p.screenshots,
      thumbnail: p.thumbnail,
      coverImage: p.coverImage,
      videoUrl: p.videoUrl,
      githubLink: p.githubLink,
      liveLink: p.liveLink,
      playStoreUrl: p.playStoreUrl,
      appStoreUrl: p.appStoreUrl,
      featured: p.featured,
      privateProject: p.privateProject,
      canShowScreenshots: p.canShowScreenshots,
      canShowCompanyName: p.canShowCompanyName,
      links: p.links
          .map((l) => ProjectLinkDto(label: l.label, url: l.url))
          .toList(),
      statistics: p.statistics
          .map((s) => ProjectStatisticDto(label: s.label, $value: s.value))
          .toList(),
      apps: p.apps
          .map(
            (a) => ProjectAppDto(
              label: a.label,
              platform: a.platform,
              screenshots: a.screenshots,
            ),
          )
          .toList(),
    );
  }

  Future<List<ProjectModel>> getAll() async {
    final response = await mainClient.apiProjectsGet();
    return (response.body ?? const []).map(_fromDto).toList();
  }

  Future<List<ProjectModel>> getFeatured() async {
    final response = await mainClient.apiProjectsGet(featured: true);
    return (response.body ?? const []).map(_fromDto).toList();
  }

  Future<ProjectModel?> getBySlug(String slug) async {
    try {
      final response = await mainClient.apiProjectsSlugGet(slug: slug);
      final dto = response.body;
      return dto == null ? null : _fromDto(dto);
    } on ApiException catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }

  /// There is no direct GET-by-id route on the backend; find it client-side.
  Future<ProjectModel?> getById(String id) async {
    final all = await getAll();
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<ProjectModel> create(ProjectModel project) async {
    final response = await mainClient.apiProjectsPost(
      body: _toCreateBody(project),
    );
    return _fromDto(response.body!);
  }

  Future<ProjectModel> update(ProjectModel project) async {
    final response = await mainClient.apiProjectsIdPut(
      id: int.tryParse(project.id),
      body: _toUpdateBody(project),
    );
    return _fromDto(response.body!);
  }

  Future<void> delete(String id) async {
    await mainClient.apiProjectsIdDelete(
      id: int.tryParse(id),
    );
  }

  /// Uploads an image (thumbnail/cover) and returns its served URL.
  Future<String> uploadImage(String filename, List<int> bytes) async {
    final response = await mainClient.apiUploadsPost(file: bytes);
    final data = response.body as Map;
    // The backend now stores uploads in Cloudflare R2 and returns the full
    // public URL directly (e.g. "https://pub-xxxx.r2.dev/xyz.png") — no
    // origin resolution needed, unlike the old local-disk/relative-path setup.
    return data['url'] as String;
  }
}
