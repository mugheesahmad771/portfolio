import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:portfolio/core/api_client/client_index.dart';
import 'package:portfolio/core/api_client/main_client.dart';
import 'package:portfolio/core/constants/api_constant.dart';
import 'package:portfolio/core/global/global_helpers.dart';
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

  /// Uploads an image (thumbnail/cover/screenshot) and returns its served
  /// URL.
  ///
  /// Hand-rolled with `package:http` rather than the generated
  /// [mainClient.apiUploadsPost] — Chopper's `@PartFile()` handling for a
  /// raw `List<int>` builds the multipart part via
  /// `MultipartFile.fromBytes(field, bytes)` with no `filename`, so the
  /// backend's `UploadsController` (which derives the allowed-extension
  /// check from `IFormFile.FileName`) always saw an empty filename and
  /// rejected every upload with "Only png, jpg, jpeg, webp and gif images
  /// are allowed." This builds the multipart request directly so the real
  /// filename and content type are actually sent.
  Future<String> uploadImage(String filename, List<int> bytes) async {
    var response = await _sendUpload(filename, bytes);

    // This bypasses mainClient/AuthInterceptor entirely (see class doc
    // above), so it also bypasses their automatic silent-refresh-on-401 —
    // without this, an access token that expired while the admin form was
    // sitting open would fail every upload with no retry, unlike every
    // other authenticated call in the app.
    if (response.statusCode == 401 && await _tryRefreshToken()) {
      response = await _sendUpload(filename, bytes);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(_extractErrorMessage(response), response.statusCode);
    }

    // The backend stores uploads in Cloudflare R2 and returns the full
    // public URL directly (e.g. "https://pub-xxxx.r2.dev/xyz.png") — no
    // origin resolution needed.
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['url'] as String;
  }

  Future<http.Response> _sendUpload(String filename, List<int> bytes) async {
    final baseUrl = production ? apiProdBase : apiDebugBase;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/api/Uploads'),
    )
      ..headers['Authorization'] = 'Bearer ${sessionHelper.accessToken ?? ''}'
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: filename,
          contentType: _imageContentType(filename),
        ),
      );

    final streamed = await request.send();
    return http.Response.fromStream(streamed);
  }

  /// Mirrors [MyAuthenticator]'s refresh call (main_client.dart) — that one
  /// isn't reusable here since it's private to that library and wired
  /// through chopper's Authenticator interface, which this hand-rolled
  /// request doesn't go through.
  Future<bool> _tryRefreshToken() async {
    final refreshToken = sessionHelper.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) return false;

    final baseUrl = production ? apiProdBase : apiDebugBase;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return false;
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final newAccessToken = data['token'] as String?;
      final newRefreshToken = data['refreshToken'] as String?;
      if (newAccessToken == null || newAccessToken.isEmpty) return false;

      await sessionHelper.setAccessToken(newAccessToken);
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await sessionHelper.setRefreshToken(newRefreshToken);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  MediaType _imageContentType(String filename) {
    final ext = filename.toLowerCase();
    if (ext.endsWith('.png')) return MediaType('image', 'png');
    if (ext.endsWith('.jpg') || ext.endsWith('.jpeg')) {
      return MediaType('image', 'jpeg');
    }
    if (ext.endsWith('.webp')) return MediaType('image', 'webp');
    if (ext.endsWith('.gif')) return MediaType('image', 'gif');
    return MediaType('application', 'octet-stream');
  }

  String _extractErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] is String) return body['message'] as String;
    } catch (_) {
      // Not JSON, or not the shape we expect — fall through to the default.
    }
    return 'Upload failed (${response.statusCode}).';
  }
}
