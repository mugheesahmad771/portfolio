// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

part 'api.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactSubmissionDto {
  const ContactSubmissionDto({
    this.id,
    this.name,
    this.email,
    this.message,
    this.submittedAtUtc,
  });

  factory ContactSubmissionDto.fromJson(Map<String, dynamic> json) =>
      _$ContactSubmissionDtoFromJson(json);

  static const toJsonFactory = _$ContactSubmissionDtoToJson;
  Map<String, dynamic> toJson() => _$ContactSubmissionDtoToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'submittedAtUtc')
  final DateTime? submittedAtUtc;
  static const fromJsonFactory = _$ContactSubmissionDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ContactSubmissionDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.submittedAtUtc, submittedAtUtc) ||
                const DeepCollectionEquality().equals(
                  other.submittedAtUtc,
                  submittedAtUtc,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(submittedAtUtc) ^
      runtimeType.hashCode;
}

extension $ContactSubmissionDtoExtension on ContactSubmissionDto {
  ContactSubmissionDto copyWith({
    int? id,
    String? name,
    String? email,
    String? message,
    DateTime? submittedAtUtc,
  }) {
    return ContactSubmissionDto(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
      submittedAtUtc: submittedAtUtc ?? this.submittedAtUtc,
    );
  }

  ContactSubmissionDto copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? email,
    Wrapped<String?>? message,
    Wrapped<DateTime?>? submittedAtUtc,
  }) {
    return ContactSubmissionDto(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      message: (message != null ? message.value : this.message),
      submittedAtUtc: (submittedAtUtc != null
          ? submittedAtUtc.value
          : this.submittedAtUtc),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateExperienceRequestModel {
  const CreateExperienceRequestModel({
    this.role,
    this.company,
    this.location,
    this.startDate,
    this.endDate,
    this.current,
    this.duration,
    this.responsibilities,
    this.technologies,
  });

  factory CreateExperienceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateExperienceRequestModelFromJson(json);

  static const toJsonFactory = _$CreateExperienceRequestModelToJson;
  Map<String, dynamic> toJson() => _$CreateExperienceRequestModelToJson(this);

  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @JsonKey(name: 'current')
  final bool? current;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'responsibilities', defaultValue: <String>[])
  final List<String>? responsibilities;
  @JsonKey(name: 'technologies', defaultValue: <String>[])
  final List<String>? technologies;
  static const fromJsonFactory = _$CreateExperienceRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateExperienceRequestModel &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.current, current) ||
                const DeepCollectionEquality().equals(
                  other.current,
                  current,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.responsibilities, responsibilities) ||
                const DeepCollectionEquality().equals(
                  other.responsibilities,
                  responsibilities,
                )) &&
            (identical(other.technologies, technologies) ||
                const DeepCollectionEquality().equals(
                  other.technologies,
                  technologies,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(current) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(responsibilities) ^
      const DeepCollectionEquality().hash(technologies) ^
      runtimeType.hashCode;
}

extension $CreateExperienceRequestModelExtension
    on CreateExperienceRequestModel {
  CreateExperienceRequestModel copyWith({
    String? role,
    String? company,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? current,
    String? duration,
    List<String>? responsibilities,
    List<String>? technologies,
  }) {
    return CreateExperienceRequestModel(
      role: role ?? this.role,
      company: company ?? this.company,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      current: current ?? this.current,
      duration: duration ?? this.duration,
      responsibilities: responsibilities ?? this.responsibilities,
      technologies: technologies ?? this.technologies,
    );
  }

  CreateExperienceRequestModel copyWithWrapped({
    Wrapped<String?>? role,
    Wrapped<String?>? company,
    Wrapped<String?>? location,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<bool?>? current,
    Wrapped<String?>? duration,
    Wrapped<List<String>?>? responsibilities,
    Wrapped<List<String>?>? technologies,
  }) {
    return CreateExperienceRequestModel(
      role: (role != null ? role.value : this.role),
      company: (company != null ? company.value : this.company),
      location: (location != null ? location.value : this.location),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      current: (current != null ? current.value : this.current),
      duration: (duration != null ? duration.value : this.duration),
      responsibilities: (responsibilities != null
          ? responsibilities.value
          : this.responsibilities),
      technologies: (technologies != null
          ? technologies.value
          : this.technologies),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateProjectRequestModel {
  const CreateProjectRequestModel({
    this.slug,
    this.title,
    this.company,
    this.$client,
    this.role,
    this.employmentType,
    this.duration,
    this.startDate,
    this.endDate,
    this.currentlyWorking,
    this.shortDescription,
    this.fullDescription,
    this.problemStatement,
    this.solution,
    this.responsibilities,
    this.keyFeatures,
    this.technologies,
    this.platforms,
    this.screenshots,
    this.thumbnail,
    this.coverImage,
    this.githubLink,
    this.liveLink,
    this.playStoreUrl,
    this.appStoreUrl,
    this.featured,
    this.privateProject,
    this.canShowScreenshots,
    this.canShowCompanyName,
    this.links,
    this.statistics,
    this.videoUrl,
    this.apps,
  });

  factory CreateProjectRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestModelFromJson(json);

  static const toJsonFactory = _$CreateProjectRequestModelToJson;
  Map<String, dynamic> toJson() => _$CreateProjectRequestModelToJson(this);

  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'client')
  final String? $client;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'employmentType')
  final String? employmentType;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @JsonKey(name: 'currentlyWorking')
  final bool? currentlyWorking;
  @JsonKey(name: 'shortDescription')
  final String? shortDescription;
  @JsonKey(name: 'fullDescription')
  final String? fullDescription;
  @JsonKey(name: 'problemStatement')
  final String? problemStatement;
  @JsonKey(name: 'solution')
  final String? solution;
  @JsonKey(name: 'responsibilities', defaultValue: <String>[])
  final List<String>? responsibilities;
  @JsonKey(name: 'keyFeatures', defaultValue: <String>[])
  final List<String>? keyFeatures;
  @JsonKey(name: 'technologies', defaultValue: <String>[])
  final List<String>? technologies;
  @JsonKey(name: 'platforms', defaultValue: <String>[])
  final List<String>? platforms;
  @JsonKey(name: 'screenshots', defaultValue: <String>[])
  final List<String>? screenshots;
  @JsonKey(name: 'thumbnail')
  final String? thumbnail;
  @JsonKey(name: 'coverImage')
  final String? coverImage;
  @JsonKey(name: 'githubLink')
  final String? githubLink;
  @JsonKey(name: 'liveLink')
  final String? liveLink;
  @JsonKey(name: 'playStoreUrl')
  final String? playStoreUrl;
  @JsonKey(name: 'appStoreUrl')
  final String? appStoreUrl;
  @JsonKey(name: 'featured')
  final bool? featured;
  @JsonKey(name: 'privateProject')
  final bool? privateProject;
  @JsonKey(name: 'canShowScreenshots')
  final bool? canShowScreenshots;
  @JsonKey(name: 'canShowCompanyName')
  final bool? canShowCompanyName;
  @JsonKey(name: 'links', defaultValue: <ProjectLinkDto>[])
  final List<ProjectLinkDto>? links;
  @JsonKey(name: 'statistics', defaultValue: <ProjectStatisticDto>[])
  final List<ProjectStatisticDto>? statistics;
  @JsonKey(name: 'videoUrl')
  final String? videoUrl;
  @JsonKey(name: 'apps', defaultValue: <ProjectAppDto>[])
  final List<ProjectAppDto>? apps;
  static const fromJsonFactory = _$CreateProjectRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateProjectRequestModel &&
            (identical(other.slug, slug) ||
                const DeepCollectionEquality().equals(other.slug, slug)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.$client, $client) ||
                const DeepCollectionEquality().equals(
                  other.$client,
                  $client,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.employmentType, employmentType) ||
                const DeepCollectionEquality().equals(
                  other.employmentType,
                  employmentType,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.currentlyWorking, currentlyWorking) ||
                const DeepCollectionEquality().equals(
                  other.currentlyWorking,
                  currentlyWorking,
                )) &&
            (identical(other.shortDescription, shortDescription) ||
                const DeepCollectionEquality().equals(
                  other.shortDescription,
                  shortDescription,
                )) &&
            (identical(other.fullDescription, fullDescription) ||
                const DeepCollectionEquality().equals(
                  other.fullDescription,
                  fullDescription,
                )) &&
            (identical(other.problemStatement, problemStatement) ||
                const DeepCollectionEquality().equals(
                  other.problemStatement,
                  problemStatement,
                )) &&
            (identical(other.solution, solution) ||
                const DeepCollectionEquality().equals(
                  other.solution,
                  solution,
                )) &&
            (identical(other.responsibilities, responsibilities) ||
                const DeepCollectionEquality().equals(
                  other.responsibilities,
                  responsibilities,
                )) &&
            (identical(other.keyFeatures, keyFeatures) ||
                const DeepCollectionEquality().equals(
                  other.keyFeatures,
                  keyFeatures,
                )) &&
            (identical(other.technologies, technologies) ||
                const DeepCollectionEquality().equals(
                  other.technologies,
                  technologies,
                )) &&
            (identical(other.platforms, platforms) ||
                const DeepCollectionEquality().equals(
                  other.platforms,
                  platforms,
                )) &&
            (identical(other.screenshots, screenshots) ||
                const DeepCollectionEquality().equals(
                  other.screenshots,
                  screenshots,
                )) &&
            (identical(other.thumbnail, thumbnail) ||
                const DeepCollectionEquality().equals(
                  other.thumbnail,
                  thumbnail,
                )) &&
            (identical(other.coverImage, coverImage) ||
                const DeepCollectionEquality().equals(
                  other.coverImage,
                  coverImage,
                )) &&
            (identical(other.githubLink, githubLink) ||
                const DeepCollectionEquality().equals(
                  other.githubLink,
                  githubLink,
                )) &&
            (identical(other.liveLink, liveLink) ||
                const DeepCollectionEquality().equals(
                  other.liveLink,
                  liveLink,
                )) &&
            (identical(other.playStoreUrl, playStoreUrl) ||
                const DeepCollectionEquality().equals(
                  other.playStoreUrl,
                  playStoreUrl,
                )) &&
            (identical(other.appStoreUrl, appStoreUrl) ||
                const DeepCollectionEquality().equals(
                  other.appStoreUrl,
                  appStoreUrl,
                )) &&
            (identical(other.featured, featured) ||
                const DeepCollectionEquality().equals(
                  other.featured,
                  featured,
                )) &&
            (identical(other.privateProject, privateProject) ||
                const DeepCollectionEquality().equals(
                  other.privateProject,
                  privateProject,
                )) &&
            (identical(other.canShowScreenshots, canShowScreenshots) ||
                const DeepCollectionEquality().equals(
                  other.canShowScreenshots,
                  canShowScreenshots,
                )) &&
            (identical(other.canShowCompanyName, canShowCompanyName) ||
                const DeepCollectionEquality().equals(
                  other.canShowCompanyName,
                  canShowCompanyName,
                )) &&
            (identical(other.links, links) ||
                const DeepCollectionEquality().equals(other.links, links)) &&
            (identical(other.statistics, statistics) ||
                const DeepCollectionEquality().equals(
                  other.statistics,
                  statistics,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(slug) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash($client) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(employmentType) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(currentlyWorking) ^
      const DeepCollectionEquality().hash(shortDescription) ^
      const DeepCollectionEquality().hash(fullDescription) ^
      const DeepCollectionEquality().hash(problemStatement) ^
      const DeepCollectionEquality().hash(solution) ^
      const DeepCollectionEquality().hash(responsibilities) ^
      const DeepCollectionEquality().hash(keyFeatures) ^
      const DeepCollectionEquality().hash(technologies) ^
      const DeepCollectionEquality().hash(platforms) ^
      const DeepCollectionEquality().hash(screenshots) ^
      const DeepCollectionEquality().hash(thumbnail) ^
      const DeepCollectionEquality().hash(coverImage) ^
      const DeepCollectionEquality().hash(githubLink) ^
      const DeepCollectionEquality().hash(liveLink) ^
      const DeepCollectionEquality().hash(playStoreUrl) ^
      const DeepCollectionEquality().hash(appStoreUrl) ^
      const DeepCollectionEquality().hash(featured) ^
      const DeepCollectionEquality().hash(privateProject) ^
      const DeepCollectionEquality().hash(canShowScreenshots) ^
      const DeepCollectionEquality().hash(canShowCompanyName) ^
      const DeepCollectionEquality().hash(links) ^
      const DeepCollectionEquality().hash(statistics) ^
      runtimeType.hashCode;
}

extension $CreateProjectRequestModelExtension on CreateProjectRequestModel {
  CreateProjectRequestModel copyWith({
    String? slug,
    String? title,
    String? company,
    String? $client,
    String? role,
    String? employmentType,
    String? duration,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyWorking,
    String? shortDescription,
    String? fullDescription,
    String? problemStatement,
    String? solution,
    List<String>? responsibilities,
    List<String>? keyFeatures,
    List<String>? technologies,
    List<String>? platforms,
    List<String>? screenshots,
    String? thumbnail,
    String? coverImage,
    String? githubLink,
    String? liveLink,
    String? playStoreUrl,
    String? appStoreUrl,
    bool? featured,
    bool? privateProject,
    bool? canShowScreenshots,
    bool? canShowCompanyName,
    List<ProjectLinkDto>? links,
    List<ProjectStatisticDto>? statistics,
  }) {
    return CreateProjectRequestModel(
      slug: slug ?? this.slug,
      title: title ?? this.title,
      company: company ?? this.company,
      $client: $client ?? this.$client,
      role: role ?? this.role,
      employmentType: employmentType ?? this.employmentType,
      duration: duration ?? this.duration,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      currentlyWorking: currentlyWorking ?? this.currentlyWorking,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      problemStatement: problemStatement ?? this.problemStatement,
      solution: solution ?? this.solution,
      responsibilities: responsibilities ?? this.responsibilities,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      technologies: technologies ?? this.technologies,
      platforms: platforms ?? this.platforms,
      screenshots: screenshots ?? this.screenshots,
      thumbnail: thumbnail ?? this.thumbnail,
      coverImage: coverImage ?? this.coverImage,
      githubLink: githubLink ?? this.githubLink,
      liveLink: liveLink ?? this.liveLink,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      featured: featured ?? this.featured,
      privateProject: privateProject ?? this.privateProject,
      canShowScreenshots: canShowScreenshots ?? this.canShowScreenshots,
      canShowCompanyName: canShowCompanyName ?? this.canShowCompanyName,
      links: links ?? this.links,
      statistics: statistics ?? this.statistics,
    );
  }

  CreateProjectRequestModel copyWithWrapped({
    Wrapped<String?>? slug,
    Wrapped<String?>? title,
    Wrapped<String?>? company,
    Wrapped<String?>? $client,
    Wrapped<String?>? role,
    Wrapped<String?>? employmentType,
    Wrapped<String?>? duration,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<bool?>? currentlyWorking,
    Wrapped<String?>? shortDescription,
    Wrapped<String?>? fullDescription,
    Wrapped<String?>? problemStatement,
    Wrapped<String?>? solution,
    Wrapped<List<String>?>? responsibilities,
    Wrapped<List<String>?>? keyFeatures,
    Wrapped<List<String>?>? technologies,
    Wrapped<List<String>?>? platforms,
    Wrapped<List<String>?>? screenshots,
    Wrapped<String?>? thumbnail,
    Wrapped<String?>? coverImage,
    Wrapped<String?>? githubLink,
    Wrapped<String?>? liveLink,
    Wrapped<String?>? playStoreUrl,
    Wrapped<String?>? appStoreUrl,
    Wrapped<bool?>? featured,
    Wrapped<bool?>? privateProject,
    Wrapped<bool?>? canShowScreenshots,
    Wrapped<bool?>? canShowCompanyName,
    Wrapped<List<ProjectLinkDto>?>? links,
    Wrapped<List<ProjectStatisticDto>?>? statistics,
  }) {
    return CreateProjectRequestModel(
      slug: (slug != null ? slug.value : this.slug),
      title: (title != null ? title.value : this.title),
      company: (company != null ? company.value : this.company),
      $client: ($client != null ? $client.value : this.$client),
      role: (role != null ? role.value : this.role),
      employmentType: (employmentType != null
          ? employmentType.value
          : this.employmentType),
      duration: (duration != null ? duration.value : this.duration),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      currentlyWorking: (currentlyWorking != null
          ? currentlyWorking.value
          : this.currentlyWorking),
      shortDescription: (shortDescription != null
          ? shortDescription.value
          : this.shortDescription),
      fullDescription: (fullDescription != null
          ? fullDescription.value
          : this.fullDescription),
      problemStatement: (problemStatement != null
          ? problemStatement.value
          : this.problemStatement),
      solution: (solution != null ? solution.value : this.solution),
      responsibilities: (responsibilities != null
          ? responsibilities.value
          : this.responsibilities),
      keyFeatures: (keyFeatures != null ? keyFeatures.value : this.keyFeatures),
      technologies: (technologies != null
          ? technologies.value
          : this.technologies),
      platforms: (platforms != null ? platforms.value : this.platforms),
      screenshots: (screenshots != null ? screenshots.value : this.screenshots),
      thumbnail: (thumbnail != null ? thumbnail.value : this.thumbnail),
      coverImage: (coverImage != null ? coverImage.value : this.coverImage),
      githubLink: (githubLink != null ? githubLink.value : this.githubLink),
      liveLink: (liveLink != null ? liveLink.value : this.liveLink),
      playStoreUrl: (playStoreUrl != null
          ? playStoreUrl.value
          : this.playStoreUrl),
      appStoreUrl: (appStoreUrl != null ? appStoreUrl.value : this.appStoreUrl),
      featured: (featured != null ? featured.value : this.featured),
      privateProject: (privateProject != null
          ? privateProject.value
          : this.privateProject),
      canShowScreenshots: (canShowScreenshots != null
          ? canShowScreenshots.value
          : this.canShowScreenshots),
      canShowCompanyName: (canShowCompanyName != null
          ? canShowCompanyName.value
          : this.canShowCompanyName),
      links: (links != null ? links.value : this.links),
      statistics: (statistics != null ? statistics.value : this.statistics),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ExperienceDto {
  const ExperienceDto({
    this.id,
    this.role,
    this.company,
    this.location,
    this.startDate,
    this.endDate,
    this.current,
    this.duration,
    this.responsibilities,
    this.technologies,
  });

  factory ExperienceDto.fromJson(Map<String, dynamic> json) =>
      _$ExperienceDtoFromJson(json);

  static const toJsonFactory = _$ExperienceDtoToJson;
  Map<String, dynamic> toJson() => _$ExperienceDtoToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @JsonKey(name: 'current')
  final bool? current;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'responsibilities', defaultValue: <String>[])
  final List<String>? responsibilities;
  @JsonKey(name: 'technologies', defaultValue: <String>[])
  final List<String>? technologies;
  static const fromJsonFactory = _$ExperienceDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ExperienceDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.current, current) ||
                const DeepCollectionEquality().equals(
                  other.current,
                  current,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.responsibilities, responsibilities) ||
                const DeepCollectionEquality().equals(
                  other.responsibilities,
                  responsibilities,
                )) &&
            (identical(other.technologies, technologies) ||
                const DeepCollectionEquality().equals(
                  other.technologies,
                  technologies,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(current) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(responsibilities) ^
      const DeepCollectionEquality().hash(technologies) ^
      runtimeType.hashCode;
}

extension $ExperienceDtoExtension on ExperienceDto {
  ExperienceDto copyWith({
    int? id,
    String? role,
    String? company,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? current,
    String? duration,
    List<String>? responsibilities,
    List<String>? technologies,
  }) {
    return ExperienceDto(
      id: id ?? this.id,
      role: role ?? this.role,
      company: company ?? this.company,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      current: current ?? this.current,
      duration: duration ?? this.duration,
      responsibilities: responsibilities ?? this.responsibilities,
      technologies: technologies ?? this.technologies,
    );
  }

  ExperienceDto copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? role,
    Wrapped<String?>? company,
    Wrapped<String?>? location,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<bool?>? current,
    Wrapped<String?>? duration,
    Wrapped<List<String>?>? responsibilities,
    Wrapped<List<String>?>? technologies,
  }) {
    return ExperienceDto(
      id: (id != null ? id.value : this.id),
      role: (role != null ? role.value : this.role),
      company: (company != null ? company.value : this.company),
      location: (location != null ? location.value : this.location),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      current: (current != null ? current.value : this.current),
      duration: (duration != null ? duration.value : this.duration),
      responsibilities: (responsibilities != null
          ? responsibilities.value
          : this.responsibilities),
      technologies: (technologies != null
          ? technologies.value
          : this.technologies),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LoginRequestModel {
  const LoginRequestModel({this.email, this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  static const toJsonFactory = _$LoginRequestModelToJson;
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'password')
  final String? password;
  static const fromJsonFactory = _$LoginRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoginRequestModel &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $LoginRequestModelExtension on LoginRequestModel {
  LoginRequestModel copyWith({String? email, String? password}) {
    return LoginRequestModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  LoginRequestModel copyWithWrapped({
    Wrapped<String?>? email,
    Wrapped<String?>? password,
  }) {
    return LoginRequestModel(
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LoginResponseDto {
  const LoginResponseDto({this.token, this.refreshToken});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  static const toJsonFactory = _$LoginResponseDtoToJson;
  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);

  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'refreshToken')
  final String? refreshToken;
  static const fromJsonFactory = _$LoginResponseDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoginResponseDto &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality().equals(
                  other.refreshToken,
                  refreshToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      runtimeType.hashCode;
}

extension $LoginResponseDtoExtension on LoginResponseDto {
  LoginResponseDto copyWith({String? token, String? refreshToken}) {
    return LoginResponseDto(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  LoginResponseDto copyWithWrapped({
    Wrapped<String?>? token,
    Wrapped<String?>? refreshToken,
  }) {
    return LoginResponseDto(
      token: (token != null ? token.value : this.token),
      refreshToken:
          (refreshToken != null ? refreshToken.value : this.refreshToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordRequestModel {
  const ChangePasswordRequestModel({this.currentPassword, this.newPassword});

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestModelFromJson(json);

  static const toJsonFactory = _$ChangePasswordRequestModelToJson;
  Map<String, dynamic> toJson() => _$ChangePasswordRequestModelToJson(this);

  @JsonKey(name: 'currentPassword')
  final String? currentPassword;
  @JsonKey(name: 'newPassword')
  final String? newPassword;
  static const fromJsonFactory = _$ChangePasswordRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChangePasswordRequestModel &&
            (identical(other.currentPassword, currentPassword) ||
                const DeepCollectionEquality().equals(
                  other.currentPassword,
                  currentPassword,
                )) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality().equals(
                  other.newPassword,
                  newPassword,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(currentPassword) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $ChangePasswordRequestModelExtension on ChangePasswordRequestModel {
  ChangePasswordRequestModel copyWith({
    String? currentPassword,
    String? newPassword,
  }) {
    return ChangePasswordRequestModel(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  ChangePasswordRequestModel copyWithWrapped({
    Wrapped<String?>? currentPassword,
    Wrapped<String?>? newPassword,
  }) {
    return ChangePasswordRequestModel(
      currentPassword: (currentPassword != null
          ? currentPassword.value
          : this.currentPassword),
      newPassword: (newPassword != null ? newPassword.value : this.newPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RefreshTokenRequestModel {
  const RefreshTokenRequestModel({this.refreshToken});

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestModelFromJson(json);

  static const toJsonFactory = _$RefreshTokenRequestModelToJson;
  Map<String, dynamic> toJson() => _$RefreshTokenRequestModelToJson(this);

  @JsonKey(name: 'refreshToken')
  final String? refreshToken;
  static const fromJsonFactory = _$RefreshTokenRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RefreshTokenRequestModel &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality().equals(
                  other.refreshToken,
                  refreshToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(refreshToken) ^
      runtimeType.hashCode;
}

extension $RefreshTokenRequestModelExtension on RefreshTokenRequestModel {
  RefreshTokenRequestModel copyWith({String? refreshToken}) {
    return RefreshTokenRequestModel(
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  RefreshTokenRequestModel copyWithWrapped({Wrapped<String?>? refreshToken}) {
    return RefreshTokenRequestModel(
      refreshToken:
          (refreshToken != null ? refreshToken.value : this.refreshToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProjectDto {
  const ProjectDto({
    this.id,
    this.slug,
    this.title,
    this.company,
    this.$client,
    this.role,
    this.employmentType,
    this.duration,
    this.startDate,
    this.endDate,
    this.currentlyWorking,
    this.shortDescription,
    this.fullDescription,
    this.problemStatement,
    this.solution,
    this.responsibilities,
    this.keyFeatures,
    this.technologies,
    this.platforms,
    this.screenshots,
    this.thumbnail,
    this.coverImage,
    this.githubLink,
    this.liveLink,
    this.playStoreUrl,
    this.appStoreUrl,
    this.featured,
    this.privateProject,
    this.canShowScreenshots,
    this.canShowCompanyName,
    this.createdAtUtc,
    this.updatedAtUtc,
    this.links,
    this.statistics,
    this.videoUrl,
    this.apps,
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectDtoFromJson(json);

  static const toJsonFactory = _$ProjectDtoToJson;
  Map<String, dynamic> toJson() => _$ProjectDtoToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'client')
  final String? $client;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'employmentType')
  final String? employmentType;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @JsonKey(name: 'currentlyWorking')
  final bool? currentlyWorking;
  @JsonKey(name: 'shortDescription')
  final String? shortDescription;
  @JsonKey(name: 'fullDescription')
  final String? fullDescription;
  @JsonKey(name: 'problemStatement')
  final String? problemStatement;
  @JsonKey(name: 'solution')
  final String? solution;
  @JsonKey(name: 'responsibilities', defaultValue: <String>[])
  final List<String>? responsibilities;
  @JsonKey(name: 'keyFeatures', defaultValue: <String>[])
  final List<String>? keyFeatures;
  @JsonKey(name: 'technologies', defaultValue: <String>[])
  final List<String>? technologies;
  @JsonKey(name: 'platforms', defaultValue: <String>[])
  final List<String>? platforms;
  @JsonKey(name: 'screenshots', defaultValue: <String>[])
  final List<String>? screenshots;
  @JsonKey(name: 'thumbnail')
  final String? thumbnail;
  @JsonKey(name: 'coverImage')
  final String? coverImage;
  @JsonKey(name: 'githubLink')
  final String? githubLink;
  @JsonKey(name: 'liveLink')
  final String? liveLink;
  @JsonKey(name: 'playStoreUrl')
  final String? playStoreUrl;
  @JsonKey(name: 'appStoreUrl')
  final String? appStoreUrl;
  @JsonKey(name: 'featured')
  final bool? featured;
  @JsonKey(name: 'privateProject')
  final bool? privateProject;
  @JsonKey(name: 'canShowScreenshots')
  final bool? canShowScreenshots;
  @JsonKey(name: 'canShowCompanyName')
  final bool? canShowCompanyName;
  @JsonKey(name: 'createdAtUtc')
  final DateTime? createdAtUtc;
  @JsonKey(name: 'updatedAtUtc')
  final DateTime? updatedAtUtc;
  @JsonKey(name: 'links', defaultValue: <ProjectLinkDto>[])
  final List<ProjectLinkDto>? links;
  @JsonKey(name: 'statistics', defaultValue: <ProjectStatisticDto>[])
  final List<ProjectStatisticDto>? statistics;
  @JsonKey(name: 'videoUrl')
  final String? videoUrl;
  @JsonKey(name: 'apps', defaultValue: <ProjectAppDto>[])
  final List<ProjectAppDto>? apps;
  static const fromJsonFactory = _$ProjectDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProjectDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.slug, slug) ||
                const DeepCollectionEquality().equals(other.slug, slug)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.$client, $client) ||
                const DeepCollectionEquality().equals(
                  other.$client,
                  $client,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.employmentType, employmentType) ||
                const DeepCollectionEquality().equals(
                  other.employmentType,
                  employmentType,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.currentlyWorking, currentlyWorking) ||
                const DeepCollectionEquality().equals(
                  other.currentlyWorking,
                  currentlyWorking,
                )) &&
            (identical(other.shortDescription, shortDescription) ||
                const DeepCollectionEquality().equals(
                  other.shortDescription,
                  shortDescription,
                )) &&
            (identical(other.fullDescription, fullDescription) ||
                const DeepCollectionEquality().equals(
                  other.fullDescription,
                  fullDescription,
                )) &&
            (identical(other.problemStatement, problemStatement) ||
                const DeepCollectionEquality().equals(
                  other.problemStatement,
                  problemStatement,
                )) &&
            (identical(other.solution, solution) ||
                const DeepCollectionEquality().equals(
                  other.solution,
                  solution,
                )) &&
            (identical(other.responsibilities, responsibilities) ||
                const DeepCollectionEquality().equals(
                  other.responsibilities,
                  responsibilities,
                )) &&
            (identical(other.keyFeatures, keyFeatures) ||
                const DeepCollectionEquality().equals(
                  other.keyFeatures,
                  keyFeatures,
                )) &&
            (identical(other.technologies, technologies) ||
                const DeepCollectionEquality().equals(
                  other.technologies,
                  technologies,
                )) &&
            (identical(other.platforms, platforms) ||
                const DeepCollectionEquality().equals(
                  other.platforms,
                  platforms,
                )) &&
            (identical(other.screenshots, screenshots) ||
                const DeepCollectionEquality().equals(
                  other.screenshots,
                  screenshots,
                )) &&
            (identical(other.thumbnail, thumbnail) ||
                const DeepCollectionEquality().equals(
                  other.thumbnail,
                  thumbnail,
                )) &&
            (identical(other.coverImage, coverImage) ||
                const DeepCollectionEquality().equals(
                  other.coverImage,
                  coverImage,
                )) &&
            (identical(other.githubLink, githubLink) ||
                const DeepCollectionEquality().equals(
                  other.githubLink,
                  githubLink,
                )) &&
            (identical(other.liveLink, liveLink) ||
                const DeepCollectionEquality().equals(
                  other.liveLink,
                  liveLink,
                )) &&
            (identical(other.playStoreUrl, playStoreUrl) ||
                const DeepCollectionEquality().equals(
                  other.playStoreUrl,
                  playStoreUrl,
                )) &&
            (identical(other.appStoreUrl, appStoreUrl) ||
                const DeepCollectionEquality().equals(
                  other.appStoreUrl,
                  appStoreUrl,
                )) &&
            (identical(other.featured, featured) ||
                const DeepCollectionEquality().equals(
                  other.featured,
                  featured,
                )) &&
            (identical(other.privateProject, privateProject) ||
                const DeepCollectionEquality().equals(
                  other.privateProject,
                  privateProject,
                )) &&
            (identical(other.canShowScreenshots, canShowScreenshots) ||
                const DeepCollectionEquality().equals(
                  other.canShowScreenshots,
                  canShowScreenshots,
                )) &&
            (identical(other.canShowCompanyName, canShowCompanyName) ||
                const DeepCollectionEquality().equals(
                  other.canShowCompanyName,
                  canShowCompanyName,
                )) &&
            (identical(other.createdAtUtc, createdAtUtc) ||
                const DeepCollectionEquality().equals(
                  other.createdAtUtc,
                  createdAtUtc,
                )) &&
            (identical(other.updatedAtUtc, updatedAtUtc) ||
                const DeepCollectionEquality().equals(
                  other.updatedAtUtc,
                  updatedAtUtc,
                )) &&
            (identical(other.links, links) ||
                const DeepCollectionEquality().equals(other.links, links)) &&
            (identical(other.statistics, statistics) ||
                const DeepCollectionEquality().equals(
                  other.statistics,
                  statistics,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(slug) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash($client) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(employmentType) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(currentlyWorking) ^
      const DeepCollectionEquality().hash(shortDescription) ^
      const DeepCollectionEquality().hash(fullDescription) ^
      const DeepCollectionEquality().hash(problemStatement) ^
      const DeepCollectionEquality().hash(solution) ^
      const DeepCollectionEquality().hash(responsibilities) ^
      const DeepCollectionEquality().hash(keyFeatures) ^
      const DeepCollectionEquality().hash(technologies) ^
      const DeepCollectionEquality().hash(platforms) ^
      const DeepCollectionEquality().hash(screenshots) ^
      const DeepCollectionEquality().hash(thumbnail) ^
      const DeepCollectionEquality().hash(coverImage) ^
      const DeepCollectionEquality().hash(githubLink) ^
      const DeepCollectionEquality().hash(liveLink) ^
      const DeepCollectionEquality().hash(playStoreUrl) ^
      const DeepCollectionEquality().hash(appStoreUrl) ^
      const DeepCollectionEquality().hash(featured) ^
      const DeepCollectionEquality().hash(privateProject) ^
      const DeepCollectionEquality().hash(canShowScreenshots) ^
      const DeepCollectionEquality().hash(canShowCompanyName) ^
      const DeepCollectionEquality().hash(createdAtUtc) ^
      const DeepCollectionEquality().hash(updatedAtUtc) ^
      const DeepCollectionEquality().hash(links) ^
      const DeepCollectionEquality().hash(statistics) ^
      runtimeType.hashCode;
}

extension $ProjectDtoExtension on ProjectDto {
  ProjectDto copyWith({
    int? id,
    String? slug,
    String? title,
    String? company,
    String? $client,
    String? role,
    String? employmentType,
    String? duration,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyWorking,
    String? shortDescription,
    String? fullDescription,
    String? problemStatement,
    String? solution,
    List<String>? responsibilities,
    List<String>? keyFeatures,
    List<String>? technologies,
    List<String>? platforms,
    List<String>? screenshots,
    String? thumbnail,
    String? coverImage,
    String? githubLink,
    String? liveLink,
    String? playStoreUrl,
    String? appStoreUrl,
    bool? featured,
    bool? privateProject,
    bool? canShowScreenshots,
    bool? canShowCompanyName,
    DateTime? createdAtUtc,
    DateTime? updatedAtUtc,
    List<ProjectLinkDto>? links,
    List<ProjectStatisticDto>? statistics,
  }) {
    return ProjectDto(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      company: company ?? this.company,
      $client: $client ?? this.$client,
      role: role ?? this.role,
      employmentType: employmentType ?? this.employmentType,
      duration: duration ?? this.duration,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      currentlyWorking: currentlyWorking ?? this.currentlyWorking,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      problemStatement: problemStatement ?? this.problemStatement,
      solution: solution ?? this.solution,
      responsibilities: responsibilities ?? this.responsibilities,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      technologies: technologies ?? this.technologies,
      platforms: platforms ?? this.platforms,
      screenshots: screenshots ?? this.screenshots,
      thumbnail: thumbnail ?? this.thumbnail,
      coverImage: coverImage ?? this.coverImage,
      githubLink: githubLink ?? this.githubLink,
      liveLink: liveLink ?? this.liveLink,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      featured: featured ?? this.featured,
      privateProject: privateProject ?? this.privateProject,
      canShowScreenshots: canShowScreenshots ?? this.canShowScreenshots,
      canShowCompanyName: canShowCompanyName ?? this.canShowCompanyName,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
      links: links ?? this.links,
      statistics: statistics ?? this.statistics,
    );
  }

  ProjectDto copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? slug,
    Wrapped<String?>? title,
    Wrapped<String?>? company,
    Wrapped<String?>? $client,
    Wrapped<String?>? role,
    Wrapped<String?>? employmentType,
    Wrapped<String?>? duration,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<bool?>? currentlyWorking,
    Wrapped<String?>? shortDescription,
    Wrapped<String?>? fullDescription,
    Wrapped<String?>? problemStatement,
    Wrapped<String?>? solution,
    Wrapped<List<String>?>? responsibilities,
    Wrapped<List<String>?>? keyFeatures,
    Wrapped<List<String>?>? technologies,
    Wrapped<List<String>?>? platforms,
    Wrapped<List<String>?>? screenshots,
    Wrapped<String?>? thumbnail,
    Wrapped<String?>? coverImage,
    Wrapped<String?>? githubLink,
    Wrapped<String?>? liveLink,
    Wrapped<String?>? playStoreUrl,
    Wrapped<String?>? appStoreUrl,
    Wrapped<bool?>? featured,
    Wrapped<bool?>? privateProject,
    Wrapped<bool?>? canShowScreenshots,
    Wrapped<bool?>? canShowCompanyName,
    Wrapped<DateTime?>? createdAtUtc,
    Wrapped<DateTime?>? updatedAtUtc,
    Wrapped<List<ProjectLinkDto>?>? links,
    Wrapped<List<ProjectStatisticDto>?>? statistics,
  }) {
    return ProjectDto(
      id: (id != null ? id.value : this.id),
      slug: (slug != null ? slug.value : this.slug),
      title: (title != null ? title.value : this.title),
      company: (company != null ? company.value : this.company),
      $client: ($client != null ? $client.value : this.$client),
      role: (role != null ? role.value : this.role),
      employmentType: (employmentType != null
          ? employmentType.value
          : this.employmentType),
      duration: (duration != null ? duration.value : this.duration),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      currentlyWorking: (currentlyWorking != null
          ? currentlyWorking.value
          : this.currentlyWorking),
      shortDescription: (shortDescription != null
          ? shortDescription.value
          : this.shortDescription),
      fullDescription: (fullDescription != null
          ? fullDescription.value
          : this.fullDescription),
      problemStatement: (problemStatement != null
          ? problemStatement.value
          : this.problemStatement),
      solution: (solution != null ? solution.value : this.solution),
      responsibilities: (responsibilities != null
          ? responsibilities.value
          : this.responsibilities),
      keyFeatures: (keyFeatures != null ? keyFeatures.value : this.keyFeatures),
      technologies: (technologies != null
          ? technologies.value
          : this.technologies),
      platforms: (platforms != null ? platforms.value : this.platforms),
      screenshots: (screenshots != null ? screenshots.value : this.screenshots),
      thumbnail: (thumbnail != null ? thumbnail.value : this.thumbnail),
      coverImage: (coverImage != null ? coverImage.value : this.coverImage),
      githubLink: (githubLink != null ? githubLink.value : this.githubLink),
      liveLink: (liveLink != null ? liveLink.value : this.liveLink),
      playStoreUrl: (playStoreUrl != null
          ? playStoreUrl.value
          : this.playStoreUrl),
      appStoreUrl: (appStoreUrl != null ? appStoreUrl.value : this.appStoreUrl),
      featured: (featured != null ? featured.value : this.featured),
      privateProject: (privateProject != null
          ? privateProject.value
          : this.privateProject),
      canShowScreenshots: (canShowScreenshots != null
          ? canShowScreenshots.value
          : this.canShowScreenshots),
      canShowCompanyName: (canShowCompanyName != null
          ? canShowCompanyName.value
          : this.canShowCompanyName),
      createdAtUtc: (createdAtUtc != null
          ? createdAtUtc.value
          : this.createdAtUtc),
      updatedAtUtc: (updatedAtUtc != null
          ? updatedAtUtc.value
          : this.updatedAtUtc),
      links: (links != null ? links.value : this.links),
      statistics: (statistics != null ? statistics.value : this.statistics),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProjectLinkDto {
  const ProjectLinkDto({this.label, this.url});

  factory ProjectLinkDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectLinkDtoFromJson(json);

  static const toJsonFactory = _$ProjectLinkDtoToJson;
  Map<String, dynamic> toJson() => _$ProjectLinkDtoToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'url')
  final String? url;
  static const fromJsonFactory = _$ProjectLinkDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProjectLinkDto &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $ProjectLinkDtoExtension on ProjectLinkDto {
  ProjectLinkDto copyWith({String? label, String? url}) {
    return ProjectLinkDto(label: label ?? this.label, url: url ?? this.url);
  }

  ProjectLinkDto copyWithWrapped({
    Wrapped<String?>? label,
    Wrapped<String?>? url,
  }) {
    return ProjectLinkDto(
      label: (label != null ? label.value : this.label),
      url: (url != null ? url.value : this.url),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProjectStatisticDto {
  const ProjectStatisticDto({this.label, this.$value});

  factory ProjectStatisticDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectStatisticDtoFromJson(json);

  static const toJsonFactory = _$ProjectStatisticDtoToJson;
  Map<String, dynamic> toJson() => _$ProjectStatisticDtoToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'value')
  final String? $value;
  static const fromJsonFactory = _$ProjectStatisticDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProjectStatisticDto &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash($value) ^
      runtimeType.hashCode;
}

extension $ProjectStatisticDtoExtension on ProjectStatisticDto {
  ProjectStatisticDto copyWith({String? label, String? $value}) {
    return ProjectStatisticDto(
      label: label ?? this.label,
      $value: $value ?? this.$value,
    );
  }

  ProjectStatisticDto copyWithWrapped({
    Wrapped<String?>? label,
    Wrapped<String?>? $value,
  }) {
    return ProjectStatisticDto(
      label: (label != null ? label.value : this.label),
      $value: ($value != null ? $value.value : this.$value),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProjectAppDto {
  const ProjectAppDto({this.label, this.platform, this.screenshots});

  factory ProjectAppDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectAppDtoFromJson(json);

  static const toJsonFactory = _$ProjectAppDtoToJson;
  Map<String, dynamic> toJson() => _$ProjectAppDtoToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'platform')
  final String? platform;
  @JsonKey(name: 'screenshots', defaultValue: <String>[])
  final List<String>? screenshots;
  static const fromJsonFactory = _$ProjectAppDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProjectAppDto &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.platform, platform) ||
                const DeepCollectionEquality().equals(
                  other.platform,
                  platform,
                )) &&
            (identical(other.screenshots, screenshots) ||
                const DeepCollectionEquality().equals(
                  other.screenshots,
                  screenshots,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(platform) ^
      const DeepCollectionEquality().hash(screenshots) ^
      runtimeType.hashCode;
}

extension $ProjectAppDtoExtension on ProjectAppDto {
  ProjectAppDto copyWith({
    String? label,
    String? platform,
    List<String>? screenshots,
  }) {
    return ProjectAppDto(
      label: label ?? this.label,
      platform: platform ?? this.platform,
      screenshots: screenshots ?? this.screenshots,
    );
  }

  ProjectAppDto copyWithWrapped({
    Wrapped<String?>? label,
    Wrapped<String?>? platform,
    Wrapped<List<String>?>? screenshots,
  }) {
    return ProjectAppDto(
      label: (label != null ? label.value : this.label),
      platform: (platform != null ? platform.value : this.platform),
      screenshots: (screenshots != null
          ? screenshots.value
          : this.screenshots),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SubmitContactRequestModel {
  const SubmitContactRequestModel({this.name, this.email, this.message});

  factory SubmitContactRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitContactRequestModelFromJson(json);

  static const toJsonFactory = _$SubmitContactRequestModelToJson;
  Map<String, dynamic> toJson() => _$SubmitContactRequestModelToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$SubmitContactRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SubmitContactRequestModel &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $SubmitContactRequestModelExtension on SubmitContactRequestModel {
  SubmitContactRequestModel copyWith({
    String? name,
    String? email,
    String? message,
  }) {
    return SubmitContactRequestModel(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }

  SubmitContactRequestModel copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? email,
    Wrapped<String?>? message,
  }) {
    return SubmitContactRequestModel(
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateExperienceRequestModel {
  const UpdateExperienceRequestModel({
    this.id,
    this.role,
    this.company,
    this.location,
    this.startDate,
    this.endDate,
    this.current,
    this.duration,
    this.responsibilities,
    this.technologies,
  });

  factory UpdateExperienceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateExperienceRequestModelFromJson(json);

  static const toJsonFactory = _$UpdateExperienceRequestModelToJson;
  Map<String, dynamic> toJson() => _$UpdateExperienceRequestModelToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @JsonKey(name: 'current')
  final bool? current;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'responsibilities', defaultValue: <String>[])
  final List<String>? responsibilities;
  @JsonKey(name: 'technologies', defaultValue: <String>[])
  final List<String>? technologies;
  static const fromJsonFactory = _$UpdateExperienceRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateExperienceRequestModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.current, current) ||
                const DeepCollectionEquality().equals(
                  other.current,
                  current,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.responsibilities, responsibilities) ||
                const DeepCollectionEquality().equals(
                  other.responsibilities,
                  responsibilities,
                )) &&
            (identical(other.technologies, technologies) ||
                const DeepCollectionEquality().equals(
                  other.technologies,
                  technologies,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(current) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(responsibilities) ^
      const DeepCollectionEquality().hash(technologies) ^
      runtimeType.hashCode;
}

extension $UpdateExperienceRequestModelExtension
    on UpdateExperienceRequestModel {
  UpdateExperienceRequestModel copyWith({
    int? id,
    String? role,
    String? company,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? current,
    String? duration,
    List<String>? responsibilities,
    List<String>? technologies,
  }) {
    return UpdateExperienceRequestModel(
      id: id ?? this.id,
      role: role ?? this.role,
      company: company ?? this.company,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      current: current ?? this.current,
      duration: duration ?? this.duration,
      responsibilities: responsibilities ?? this.responsibilities,
      technologies: technologies ?? this.technologies,
    );
  }

  UpdateExperienceRequestModel copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? role,
    Wrapped<String?>? company,
    Wrapped<String?>? location,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<bool?>? current,
    Wrapped<String?>? duration,
    Wrapped<List<String>?>? responsibilities,
    Wrapped<List<String>?>? technologies,
  }) {
    return UpdateExperienceRequestModel(
      id: (id != null ? id.value : this.id),
      role: (role != null ? role.value : this.role),
      company: (company != null ? company.value : this.company),
      location: (location != null ? location.value : this.location),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      current: (current != null ? current.value : this.current),
      duration: (duration != null ? duration.value : this.duration),
      responsibilities: (responsibilities != null
          ? responsibilities.value
          : this.responsibilities),
      technologies: (technologies != null
          ? technologies.value
          : this.technologies),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateProjectRequestModel {
  const UpdateProjectRequestModel({
    this.id,
    this.slug,
    this.title,
    this.company,
    this.$client,
    this.role,
    this.employmentType,
    this.duration,
    this.startDate,
    this.endDate,
    this.currentlyWorking,
    this.shortDescription,
    this.fullDescription,
    this.problemStatement,
    this.solution,
    this.responsibilities,
    this.keyFeatures,
    this.technologies,
    this.platforms,
    this.screenshots,
    this.thumbnail,
    this.coverImage,
    this.githubLink,
    this.liveLink,
    this.playStoreUrl,
    this.appStoreUrl,
    this.featured,
    this.privateProject,
    this.canShowScreenshots,
    this.canShowCompanyName,
    this.links,
    this.statistics,
    this.videoUrl,
    this.apps,
  });

  factory UpdateProjectRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectRequestModelFromJson(json);

  static const toJsonFactory = _$UpdateProjectRequestModelToJson;
  Map<String, dynamic> toJson() => _$UpdateProjectRequestModelToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'client')
  final String? $client;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'employmentType')
  final String? employmentType;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @JsonKey(name: 'currentlyWorking')
  final bool? currentlyWorking;
  @JsonKey(name: 'shortDescription')
  final String? shortDescription;
  @JsonKey(name: 'fullDescription')
  final String? fullDescription;
  @JsonKey(name: 'problemStatement')
  final String? problemStatement;
  @JsonKey(name: 'solution')
  final String? solution;
  @JsonKey(name: 'responsibilities', defaultValue: <String>[])
  final List<String>? responsibilities;
  @JsonKey(name: 'keyFeatures', defaultValue: <String>[])
  final List<String>? keyFeatures;
  @JsonKey(name: 'technologies', defaultValue: <String>[])
  final List<String>? technologies;
  @JsonKey(name: 'platforms', defaultValue: <String>[])
  final List<String>? platforms;
  @JsonKey(name: 'screenshots', defaultValue: <String>[])
  final List<String>? screenshots;
  @JsonKey(name: 'thumbnail')
  final String? thumbnail;
  @JsonKey(name: 'coverImage')
  final String? coverImage;
  @JsonKey(name: 'githubLink')
  final String? githubLink;
  @JsonKey(name: 'liveLink')
  final String? liveLink;
  @JsonKey(name: 'playStoreUrl')
  final String? playStoreUrl;
  @JsonKey(name: 'appStoreUrl')
  final String? appStoreUrl;
  @JsonKey(name: 'featured')
  final bool? featured;
  @JsonKey(name: 'privateProject')
  final bool? privateProject;
  @JsonKey(name: 'canShowScreenshots')
  final bool? canShowScreenshots;
  @JsonKey(name: 'canShowCompanyName')
  final bool? canShowCompanyName;
  @JsonKey(name: 'links', defaultValue: <ProjectLinkDto>[])
  final List<ProjectLinkDto>? links;
  @JsonKey(name: 'statistics', defaultValue: <ProjectStatisticDto>[])
  final List<ProjectStatisticDto>? statistics;
  @JsonKey(name: 'videoUrl')
  final String? videoUrl;
  @JsonKey(name: 'apps', defaultValue: <ProjectAppDto>[])
  final List<ProjectAppDto>? apps;
  static const fromJsonFactory = _$UpdateProjectRequestModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateProjectRequestModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.slug, slug) ||
                const DeepCollectionEquality().equals(other.slug, slug)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.$client, $client) ||
                const DeepCollectionEquality().equals(
                  other.$client,
                  $client,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.employmentType, employmentType) ||
                const DeepCollectionEquality().equals(
                  other.employmentType,
                  employmentType,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.currentlyWorking, currentlyWorking) ||
                const DeepCollectionEquality().equals(
                  other.currentlyWorking,
                  currentlyWorking,
                )) &&
            (identical(other.shortDescription, shortDescription) ||
                const DeepCollectionEquality().equals(
                  other.shortDescription,
                  shortDescription,
                )) &&
            (identical(other.fullDescription, fullDescription) ||
                const DeepCollectionEquality().equals(
                  other.fullDescription,
                  fullDescription,
                )) &&
            (identical(other.problemStatement, problemStatement) ||
                const DeepCollectionEquality().equals(
                  other.problemStatement,
                  problemStatement,
                )) &&
            (identical(other.solution, solution) ||
                const DeepCollectionEquality().equals(
                  other.solution,
                  solution,
                )) &&
            (identical(other.responsibilities, responsibilities) ||
                const DeepCollectionEquality().equals(
                  other.responsibilities,
                  responsibilities,
                )) &&
            (identical(other.keyFeatures, keyFeatures) ||
                const DeepCollectionEquality().equals(
                  other.keyFeatures,
                  keyFeatures,
                )) &&
            (identical(other.technologies, technologies) ||
                const DeepCollectionEquality().equals(
                  other.technologies,
                  technologies,
                )) &&
            (identical(other.platforms, platforms) ||
                const DeepCollectionEquality().equals(
                  other.platforms,
                  platforms,
                )) &&
            (identical(other.screenshots, screenshots) ||
                const DeepCollectionEquality().equals(
                  other.screenshots,
                  screenshots,
                )) &&
            (identical(other.thumbnail, thumbnail) ||
                const DeepCollectionEquality().equals(
                  other.thumbnail,
                  thumbnail,
                )) &&
            (identical(other.coverImage, coverImage) ||
                const DeepCollectionEquality().equals(
                  other.coverImage,
                  coverImage,
                )) &&
            (identical(other.githubLink, githubLink) ||
                const DeepCollectionEquality().equals(
                  other.githubLink,
                  githubLink,
                )) &&
            (identical(other.liveLink, liveLink) ||
                const DeepCollectionEquality().equals(
                  other.liveLink,
                  liveLink,
                )) &&
            (identical(other.playStoreUrl, playStoreUrl) ||
                const DeepCollectionEquality().equals(
                  other.playStoreUrl,
                  playStoreUrl,
                )) &&
            (identical(other.appStoreUrl, appStoreUrl) ||
                const DeepCollectionEquality().equals(
                  other.appStoreUrl,
                  appStoreUrl,
                )) &&
            (identical(other.featured, featured) ||
                const DeepCollectionEquality().equals(
                  other.featured,
                  featured,
                )) &&
            (identical(other.privateProject, privateProject) ||
                const DeepCollectionEquality().equals(
                  other.privateProject,
                  privateProject,
                )) &&
            (identical(other.canShowScreenshots, canShowScreenshots) ||
                const DeepCollectionEquality().equals(
                  other.canShowScreenshots,
                  canShowScreenshots,
                )) &&
            (identical(other.canShowCompanyName, canShowCompanyName) ||
                const DeepCollectionEquality().equals(
                  other.canShowCompanyName,
                  canShowCompanyName,
                )) &&
            (identical(other.links, links) ||
                const DeepCollectionEquality().equals(other.links, links)) &&
            (identical(other.statistics, statistics) ||
                const DeepCollectionEquality().equals(
                  other.statistics,
                  statistics,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(slug) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash($client) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(employmentType) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(currentlyWorking) ^
      const DeepCollectionEquality().hash(shortDescription) ^
      const DeepCollectionEquality().hash(fullDescription) ^
      const DeepCollectionEquality().hash(problemStatement) ^
      const DeepCollectionEquality().hash(solution) ^
      const DeepCollectionEquality().hash(responsibilities) ^
      const DeepCollectionEquality().hash(keyFeatures) ^
      const DeepCollectionEquality().hash(technologies) ^
      const DeepCollectionEquality().hash(platforms) ^
      const DeepCollectionEquality().hash(screenshots) ^
      const DeepCollectionEquality().hash(thumbnail) ^
      const DeepCollectionEquality().hash(coverImage) ^
      const DeepCollectionEquality().hash(githubLink) ^
      const DeepCollectionEquality().hash(liveLink) ^
      const DeepCollectionEquality().hash(playStoreUrl) ^
      const DeepCollectionEquality().hash(appStoreUrl) ^
      const DeepCollectionEquality().hash(featured) ^
      const DeepCollectionEquality().hash(privateProject) ^
      const DeepCollectionEquality().hash(canShowScreenshots) ^
      const DeepCollectionEquality().hash(canShowCompanyName) ^
      const DeepCollectionEquality().hash(links) ^
      const DeepCollectionEquality().hash(statistics) ^
      runtimeType.hashCode;
}

extension $UpdateProjectRequestModelExtension on UpdateProjectRequestModel {
  UpdateProjectRequestModel copyWith({
    int? id,
    String? slug,
    String? title,
    String? company,
    String? $client,
    String? role,
    String? employmentType,
    String? duration,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyWorking,
    String? shortDescription,
    String? fullDescription,
    String? problemStatement,
    String? solution,
    List<String>? responsibilities,
    List<String>? keyFeatures,
    List<String>? technologies,
    List<String>? platforms,
    List<String>? screenshots,
    String? thumbnail,
    String? coverImage,
    String? githubLink,
    String? liveLink,
    String? playStoreUrl,
    String? appStoreUrl,
    bool? featured,
    bool? privateProject,
    bool? canShowScreenshots,
    bool? canShowCompanyName,
    List<ProjectLinkDto>? links,
    List<ProjectStatisticDto>? statistics,
  }) {
    return UpdateProjectRequestModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      company: company ?? this.company,
      $client: $client ?? this.$client,
      role: role ?? this.role,
      employmentType: employmentType ?? this.employmentType,
      duration: duration ?? this.duration,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      currentlyWorking: currentlyWorking ?? this.currentlyWorking,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      problemStatement: problemStatement ?? this.problemStatement,
      solution: solution ?? this.solution,
      responsibilities: responsibilities ?? this.responsibilities,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      technologies: technologies ?? this.technologies,
      platforms: platforms ?? this.platforms,
      screenshots: screenshots ?? this.screenshots,
      thumbnail: thumbnail ?? this.thumbnail,
      coverImage: coverImage ?? this.coverImage,
      githubLink: githubLink ?? this.githubLink,
      liveLink: liveLink ?? this.liveLink,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      featured: featured ?? this.featured,
      privateProject: privateProject ?? this.privateProject,
      canShowScreenshots: canShowScreenshots ?? this.canShowScreenshots,
      canShowCompanyName: canShowCompanyName ?? this.canShowCompanyName,
      links: links ?? this.links,
      statistics: statistics ?? this.statistics,
    );
  }

  UpdateProjectRequestModel copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? slug,
    Wrapped<String?>? title,
    Wrapped<String?>? company,
    Wrapped<String?>? $client,
    Wrapped<String?>? role,
    Wrapped<String?>? employmentType,
    Wrapped<String?>? duration,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<bool?>? currentlyWorking,
    Wrapped<String?>? shortDescription,
    Wrapped<String?>? fullDescription,
    Wrapped<String?>? problemStatement,
    Wrapped<String?>? solution,
    Wrapped<List<String>?>? responsibilities,
    Wrapped<List<String>?>? keyFeatures,
    Wrapped<List<String>?>? technologies,
    Wrapped<List<String>?>? platforms,
    Wrapped<List<String>?>? screenshots,
    Wrapped<String?>? thumbnail,
    Wrapped<String?>? coverImage,
    Wrapped<String?>? githubLink,
    Wrapped<String?>? liveLink,
    Wrapped<String?>? playStoreUrl,
    Wrapped<String?>? appStoreUrl,
    Wrapped<bool?>? featured,
    Wrapped<bool?>? privateProject,
    Wrapped<bool?>? canShowScreenshots,
    Wrapped<bool?>? canShowCompanyName,
    Wrapped<List<ProjectLinkDto>?>? links,
    Wrapped<List<ProjectStatisticDto>?>? statistics,
  }) {
    return UpdateProjectRequestModel(
      id: (id != null ? id.value : this.id),
      slug: (slug != null ? slug.value : this.slug),
      title: (title != null ? title.value : this.title),
      company: (company != null ? company.value : this.company),
      $client: ($client != null ? $client.value : this.$client),
      role: (role != null ? role.value : this.role),
      employmentType: (employmentType != null
          ? employmentType.value
          : this.employmentType),
      duration: (duration != null ? duration.value : this.duration),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      currentlyWorking: (currentlyWorking != null
          ? currentlyWorking.value
          : this.currentlyWorking),
      shortDescription: (shortDescription != null
          ? shortDescription.value
          : this.shortDescription),
      fullDescription: (fullDescription != null
          ? fullDescription.value
          : this.fullDescription),
      problemStatement: (problemStatement != null
          ? problemStatement.value
          : this.problemStatement),
      solution: (solution != null ? solution.value : this.solution),
      responsibilities: (responsibilities != null
          ? responsibilities.value
          : this.responsibilities),
      keyFeatures: (keyFeatures != null ? keyFeatures.value : this.keyFeatures),
      technologies: (technologies != null
          ? technologies.value
          : this.technologies),
      platforms: (platforms != null ? platforms.value : this.platforms),
      screenshots: (screenshots != null ? screenshots.value : this.screenshots),
      thumbnail: (thumbnail != null ? thumbnail.value : this.thumbnail),
      coverImage: (coverImage != null ? coverImage.value : this.coverImage),
      githubLink: (githubLink != null ? githubLink.value : this.githubLink),
      liveLink: (liveLink != null ? liveLink.value : this.liveLink),
      playStoreUrl: (playStoreUrl != null
          ? playStoreUrl.value
          : this.playStoreUrl),
      appStoreUrl: (appStoreUrl != null ? appStoreUrl.value : this.appStoreUrl),
      featured: (featured != null ? featured.value : this.featured),
      privateProject: (privateProject != null
          ? privateProject.value
          : this.privateProject),
      canShowScreenshots: (canShowScreenshots != null
          ? canShowScreenshots.value
          : this.canShowScreenshots),
      canShowCompanyName: (canShowCompanyName != null
          ? canShowCompanyName.value
          : this.canShowCompanyName),
      links: (links != null ? links.value : this.links),
      statistics: (statistics != null ? statistics.value : this.statistics),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ApiUploadsPost$RequestBody {
  const ApiUploadsPost$RequestBody({this.file});

  factory ApiUploadsPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$ApiUploadsPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$ApiUploadsPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$ApiUploadsPost$RequestBodyToJson(this);

  @JsonKey(name: 'file')
  final String? file;
  static const fromJsonFactory = _$ApiUploadsPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiUploadsPost$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $ApiUploadsPost$RequestBodyExtension on ApiUploadsPost$RequestBody {
  ApiUploadsPost$RequestBody copyWith({String? file}) {
    return ApiUploadsPost$RequestBody(file: file ?? this.file);
  }

  ApiUploadsPost$RequestBody copyWithWrapped({Wrapped<String?>? file}) {
    return ApiUploadsPost$RequestBody(
      file: (file != null ? file.value : this.file),
    );
  }
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
