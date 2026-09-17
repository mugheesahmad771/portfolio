// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactSubmissionDto _$ContactSubmissionDtoFromJson(
        Map<String, dynamic> json) =>
    ContactSubmissionDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      message: json['message'] as String?,
      submittedAtUtc: json['submittedAtUtc'] == null
          ? null
          : DateTime.parse(json['submittedAtUtc'] as String),
    );

Map<String, dynamic> _$ContactSubmissionDtoToJson(
        ContactSubmissionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'message': instance.message,
      'submittedAtUtc': instance.submittedAtUtc?.toIso8601String(),
    };

CreateExperienceRequestModel _$CreateExperienceRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateExperienceRequestModel(
      role: json['role'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      current: json['current'] as bool?,
      duration: json['duration'] as String?,
      responsibilities: (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreateExperienceRequestModelToJson(
        CreateExperienceRequestModel instance) =>
    <String, dynamic>{
      'role': instance.role,
      'company': instance.company,
      'location': instance.location,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'current': instance.current,
      'duration': instance.duration,
      'responsibilities': instance.responsibilities,
      'technologies': instance.technologies,
    };

CreateProjectRequestModel _$CreateProjectRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateProjectRequestModel(
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      company: json['company'] as String?,
      $client: json['client'] as String?,
      role: json['role'] as String?,
      employmentType: json['employmentType'] as String?,
      duration: json['duration'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      currentlyWorking: json['currentlyWorking'] as bool?,
      shortDescription: json['shortDescription'] as String?,
      fullDescription: json['fullDescription'] as String?,
      problemStatement: json['problemStatement'] as String?,
      solution: json['solution'] as String?,
      responsibilities: (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      keyFeatures: (json['keyFeatures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      screenshots: (json['screenshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      thumbnail: json['thumbnail'] as String?,
      coverImage: json['coverImage'] as String?,
      githubLink: json['githubLink'] as String?,
      liveLink: json['liveLink'] as String?,
      playStoreUrl: json['playStoreUrl'] as String?,
      appStoreUrl: json['appStoreUrl'] as String?,
      featured: json['featured'] as bool?,
      privateProject: json['privateProject'] as bool?,
      canShowScreenshots: json['canShowScreenshots'] as bool?,
      canShowCompanyName: json['canShowCompanyName'] as bool?,
      links: (json['links'] as List<dynamic>?)
              ?.map((e) => ProjectLinkDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      statistics: (json['statistics'] as List<dynamic>?)
              ?.map((e) =>
                  ProjectStatisticDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      videoUrl: json['videoUrl'] as String?,
      apps: (json['apps'] as List<dynamic>?)
              ?.map((e) => ProjectAppDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreateProjectRequestModelToJson(
        CreateProjectRequestModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'title': instance.title,
      'company': instance.company,
      'client': instance.$client,
      'role': instance.role,
      'employmentType': instance.employmentType,
      'duration': instance.duration,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'currentlyWorking': instance.currentlyWorking,
      'shortDescription': instance.shortDescription,
      'fullDescription': instance.fullDescription,
      'problemStatement': instance.problemStatement,
      'solution': instance.solution,
      'responsibilities': instance.responsibilities,
      'keyFeatures': instance.keyFeatures,
      'technologies': instance.technologies,
      'platforms': instance.platforms,
      'screenshots': instance.screenshots,
      'thumbnail': instance.thumbnail,
      'coverImage': instance.coverImage,
      'githubLink': instance.githubLink,
      'liveLink': instance.liveLink,
      'playStoreUrl': instance.playStoreUrl,
      'appStoreUrl': instance.appStoreUrl,
      'featured': instance.featured,
      'privateProject': instance.privateProject,
      'canShowScreenshots': instance.canShowScreenshots,
      'canShowCompanyName': instance.canShowCompanyName,
      'links': instance.links?.map((e) => e.toJson()).toList(),
      'statistics': instance.statistics?.map((e) => e.toJson()).toList(),
      'videoUrl': instance.videoUrl,
      'apps': instance.apps?.map((e) => e.toJson()).toList(),
    };

ExperienceDto _$ExperienceDtoFromJson(Map<String, dynamic> json) =>
    ExperienceDto(
      id: (json['id'] as num?)?.toInt(),
      role: json['role'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      current: json['current'] as bool?,
      duration: json['duration'] as String?,
      responsibilities: (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ExperienceDtoToJson(ExperienceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'company': instance.company,
      'location': instance.location,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'current': instance.current,
      'duration': instance.duration,
      'responsibilities': instance.responsibilities,
      'technologies': instance.technologies,
    };

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    LoginRequestModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) =>
    LoginResponseDto(
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$LoginResponseDtoToJson(LoginResponseDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };

ChangePasswordRequestModel _$ChangePasswordRequestModelFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequestModel(
      currentPassword: json['currentPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ChangePasswordRequestModelToJson(
        ChangePasswordRequestModel instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
    };

RefreshTokenRequestModel _$RefreshTokenRequestModelFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenRequestModel(
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$RefreshTokenRequestModelToJson(
        RefreshTokenRequestModel instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
    };

ProjectDto _$ProjectDtoFromJson(Map<String, dynamic> json) => ProjectDto(
      id: (json['id'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      company: json['company'] as String?,
      $client: json['client'] as String?,
      role: json['role'] as String?,
      employmentType: json['employmentType'] as String?,
      duration: json['duration'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      currentlyWorking: json['currentlyWorking'] as bool?,
      shortDescription: json['shortDescription'] as String?,
      fullDescription: json['fullDescription'] as String?,
      problemStatement: json['problemStatement'] as String?,
      solution: json['solution'] as String?,
      responsibilities: (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      keyFeatures: (json['keyFeatures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      screenshots: (json['screenshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      thumbnail: json['thumbnail'] as String?,
      coverImage: json['coverImage'] as String?,
      githubLink: json['githubLink'] as String?,
      liveLink: json['liveLink'] as String?,
      playStoreUrl: json['playStoreUrl'] as String?,
      appStoreUrl: json['appStoreUrl'] as String?,
      featured: json['featured'] as bool?,
      privateProject: json['privateProject'] as bool?,
      canShowScreenshots: json['canShowScreenshots'] as bool?,
      canShowCompanyName: json['canShowCompanyName'] as bool?,
      createdAtUtc: json['createdAtUtc'] == null
          ? null
          : DateTime.parse(json['createdAtUtc'] as String),
      updatedAtUtc: json['updatedAtUtc'] == null
          ? null
          : DateTime.parse(json['updatedAtUtc'] as String),
      links: (json['links'] as List<dynamic>?)
              ?.map((e) => ProjectLinkDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      statistics: (json['statistics'] as List<dynamic>?)
              ?.map((e) =>
                  ProjectStatisticDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      videoUrl: json['videoUrl'] as String?,
      apps: (json['apps'] as List<dynamic>?)
              ?.map((e) => ProjectAppDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProjectDtoToJson(ProjectDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'company': instance.company,
      'client': instance.$client,
      'role': instance.role,
      'employmentType': instance.employmentType,
      'duration': instance.duration,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'currentlyWorking': instance.currentlyWorking,
      'shortDescription': instance.shortDescription,
      'fullDescription': instance.fullDescription,
      'problemStatement': instance.problemStatement,
      'solution': instance.solution,
      'responsibilities': instance.responsibilities,
      'keyFeatures': instance.keyFeatures,
      'technologies': instance.technologies,
      'platforms': instance.platforms,
      'screenshots': instance.screenshots,
      'thumbnail': instance.thumbnail,
      'coverImage': instance.coverImage,
      'githubLink': instance.githubLink,
      'liveLink': instance.liveLink,
      'playStoreUrl': instance.playStoreUrl,
      'appStoreUrl': instance.appStoreUrl,
      'featured': instance.featured,
      'privateProject': instance.privateProject,
      'canShowScreenshots': instance.canShowScreenshots,
      'canShowCompanyName': instance.canShowCompanyName,
      'createdAtUtc': instance.createdAtUtc?.toIso8601String(),
      'updatedAtUtc': instance.updatedAtUtc?.toIso8601String(),
      'links': instance.links?.map((e) => e.toJson()).toList(),
      'statistics': instance.statistics?.map((e) => e.toJson()).toList(),
      'videoUrl': instance.videoUrl,
      'apps': instance.apps?.map((e) => e.toJson()).toList(),
    };

ProjectLinkDto _$ProjectLinkDtoFromJson(Map<String, dynamic> json) =>
    ProjectLinkDto(
      label: json['label'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ProjectLinkDtoToJson(ProjectLinkDto instance) =>
    <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
    };

ProjectStatisticDto _$ProjectStatisticDtoFromJson(Map<String, dynamic> json) =>
    ProjectStatisticDto(
      label: json['label'] as String?,
      $value: json['value'] as String?,
    );

Map<String, dynamic> _$ProjectStatisticDtoToJson(
        ProjectStatisticDto instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.$value,
    };

ProjectAppDto _$ProjectAppDtoFromJson(Map<String, dynamic> json) =>
    ProjectAppDto(
      label: json['label'] as String?,
      platform: json['platform'] as String?,
      screenshots: (json['screenshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProjectAppDtoToJson(ProjectAppDto instance) =>
    <String, dynamic>{
      'label': instance.label,
      'platform': instance.platform,
      'screenshots': instance.screenshots,
    };

SubmitContactRequestModel _$SubmitContactRequestModelFromJson(
        Map<String, dynamic> json) =>
    SubmitContactRequestModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SubmitContactRequestModelToJson(
        SubmitContactRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'message': instance.message,
    };

UpdateExperienceRequestModel _$UpdateExperienceRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateExperienceRequestModel(
      id: (json['id'] as num?)?.toInt(),
      role: json['role'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      current: json['current'] as bool?,
      duration: json['duration'] as String?,
      responsibilities: (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$UpdateExperienceRequestModelToJson(
        UpdateExperienceRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'company': instance.company,
      'location': instance.location,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'current': instance.current,
      'duration': instance.duration,
      'responsibilities': instance.responsibilities,
      'technologies': instance.technologies,
    };

UpdateProjectRequestModel _$UpdateProjectRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateProjectRequestModel(
      id: (json['id'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      company: json['company'] as String?,
      $client: json['client'] as String?,
      role: json['role'] as String?,
      employmentType: json['employmentType'] as String?,
      duration: json['duration'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      currentlyWorking: json['currentlyWorking'] as bool?,
      shortDescription: json['shortDescription'] as String?,
      fullDescription: json['fullDescription'] as String?,
      problemStatement: json['problemStatement'] as String?,
      solution: json['solution'] as String?,
      responsibilities: (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      keyFeatures: (json['keyFeatures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      screenshots: (json['screenshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      thumbnail: json['thumbnail'] as String?,
      coverImage: json['coverImage'] as String?,
      githubLink: json['githubLink'] as String?,
      liveLink: json['liveLink'] as String?,
      playStoreUrl: json['playStoreUrl'] as String?,
      appStoreUrl: json['appStoreUrl'] as String?,
      featured: json['featured'] as bool?,
      privateProject: json['privateProject'] as bool?,
      canShowScreenshots: json['canShowScreenshots'] as bool?,
      canShowCompanyName: json['canShowCompanyName'] as bool?,
      links: (json['links'] as List<dynamic>?)
              ?.map((e) => ProjectLinkDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      statistics: (json['statistics'] as List<dynamic>?)
              ?.map((e) =>
                  ProjectStatisticDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      videoUrl: json['videoUrl'] as String?,
      apps: (json['apps'] as List<dynamic>?)
              ?.map((e) => ProjectAppDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UpdateProjectRequestModelToJson(
        UpdateProjectRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'company': instance.company,
      'client': instance.$client,
      'role': instance.role,
      'employmentType': instance.employmentType,
      'duration': instance.duration,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'currentlyWorking': instance.currentlyWorking,
      'shortDescription': instance.shortDescription,
      'fullDescription': instance.fullDescription,
      'problemStatement': instance.problemStatement,
      'solution': instance.solution,
      'responsibilities': instance.responsibilities,
      'keyFeatures': instance.keyFeatures,
      'technologies': instance.technologies,
      'platforms': instance.platforms,
      'screenshots': instance.screenshots,
      'thumbnail': instance.thumbnail,
      'coverImage': instance.coverImage,
      'githubLink': instance.githubLink,
      'liveLink': instance.liveLink,
      'playStoreUrl': instance.playStoreUrl,
      'appStoreUrl': instance.appStoreUrl,
      'featured': instance.featured,
      'privateProject': instance.privateProject,
      'canShowScreenshots': instance.canShowScreenshots,
      'canShowCompanyName': instance.canShowCompanyName,
      'links': instance.links?.map((e) => e.toJson()).toList(),
      'statistics': instance.statistics?.map((e) => e.toJson()).toList(),
      'videoUrl': instance.videoUrl,
      'apps': instance.apps?.map((e) => e.toJson()).toList(),
    };

ApiUploadsPost$RequestBody _$ApiUploadsPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    ApiUploadsPost$RequestBody(
      file: json['file'] as String?,
    );

Map<String, dynamic> _$ApiUploadsPost$RequestBodyToJson(
        ApiUploadsPost$RequestBody instance) =>
    <String, dynamic>{
      'file': instance.file,
    };
