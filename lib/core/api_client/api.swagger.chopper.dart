// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Api extends Api {
  _$Api([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Api;

  @override
  Future<Response<LoginResponseDto>> _apiAuthLoginPost(
      {required LoginRequestModel? body}) {
    final Uri $url = Uri.parse('/api/Auth/login');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginResponseDto, LoginResponseDto>($request);
  }

  @override
  Future<Response<LoginResponseDto>> _apiAuthRefreshPost(
      {required RefreshTokenRequestModel? body}) {
    final Uri $url = Uri.parse('/api/Auth/refresh');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginResponseDto, LoginResponseDto>($request);
  }

  @override
  Future<Response<ContactSubmissionDto>> _apiContactPost(
      {required SubmitContactRequestModel? body}) {
    final Uri $url = Uri.parse('/api/Contact');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ContactSubmissionDto, ContactSubmissionDto>($request);
  }

  @override
  Future<Response<List<ContactSubmissionDto>>> _apiContactGet() {
    final Uri $url = Uri.parse('/api/Contact');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<ContactSubmissionDto>, ContactSubmissionDto>($request);
  }

  @override
  Future<Response<List<ExperienceDto>>> _apiExperienceGet() {
    final Uri $url = Uri.parse('/api/Experience');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ExperienceDto>, ExperienceDto>($request);
  }

  @override
  Future<Response<ExperienceDto>> _apiExperiencePost(
      {required CreateExperienceRequestModel? body}) {
    final Uri $url = Uri.parse('/api/Experience');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ExperienceDto, ExperienceDto>($request);
  }

  @override
  Future<Response<ExperienceDto>> _apiExperienceIdPut({
    required int? id,
    required UpdateExperienceRequestModel? body,
  }) {
    final Uri $url = Uri.parse('/api/Experience/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ExperienceDto, ExperienceDto>($request);
  }

  @override
  Future<Response<dynamic>> _apiExperienceIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/Experience/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ProjectDto>>> _apiProjectsGet({bool? featured}) {
    final Uri $url = Uri.parse('/api/Projects');
    final Map<String, dynamic> $params = <String, dynamic>{
      'featured': featured
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<ProjectDto>, ProjectDto>($request);
  }

  @override
  Future<Response<ProjectDto>> _apiProjectsPost(
      {required CreateProjectRequestModel? body}) {
    final Uri $url = Uri.parse('/api/Projects');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ProjectDto, ProjectDto>($request);
  }

  @override
  Future<Response<ProjectDto>> _apiProjectsSlugGet({required String? slug}) {
    final Uri $url = Uri.parse('/api/Projects/${slug}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ProjectDto, ProjectDto>($request);
  }

  @override
  Future<Response<ProjectDto>> _apiProjectsIdPut({
    required int? id,
    required UpdateProjectRequestModel? body,
  }) {
    final Uri $url = Uri.parse('/api/Projects/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ProjectDto, ProjectDto>($request);
  }

  @override
  Future<Response<dynamic>> _apiProjectsIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/Projects/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiUploadsPost({List<int>? file}) {
    final Uri $url = Uri.parse('/api/Uploads');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>?>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
