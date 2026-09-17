import 'package:get/get.dart';
import 'package:portfolio/core/api_client/client_index.dart';
import 'package:portfolio/core/api_client/main_client.dart';
import 'package:portfolio/core/models/experience_model.dart';

/// API-backed, singleton (via [GetxService]) experience data source, talking
/// to the backend through the shared [mainClient] Chopper client.
class ExperienceService extends GetxService {
  ExperienceModel _fromDto(ExperienceDto dto) {
    return ExperienceModel(
      id: (dto.id ?? 0).toString(),
      role: dto.role ?? '',
      company: dto.company ?? '',
      location: dto.location ?? '',
      duration: dto.duration ?? '',
      startDate: dto.startDate,
      endDate: dto.endDate,
      current: dto.current ?? false,
      technologies: dto.technologies ?? const [],
      responsibilities: dto.responsibilities ?? const [],
    );
  }

  CreateExperienceRequestModel _toCreateBody(ExperienceModel model) {
    return CreateExperienceRequestModel(
      role: model.role,
      company: model.company,
      location: model.location,
      startDate: model.startDate,
      endDate: model.endDate,
      current: model.current,
      duration: model.duration,
      responsibilities: model.responsibilities,
      technologies: model.technologies,
    );
  }

  UpdateExperienceRequestModel _toUpdateBody(ExperienceModel model) {
    return UpdateExperienceRequestModel(
      id: int.tryParse(model.id),
      role: model.role,
      company: model.company,
      location: model.location,
      startDate: model.startDate,
      endDate: model.endDate,
      current: model.current,
      duration: model.duration,
      responsibilities: model.responsibilities,
      technologies: model.technologies,
    );
  }

  Future<List<ExperienceModel>> getAll() async {
    final response = await mainClient.apiExperienceGet();
    return (response.body ?? const []).map(_fromDto).toList();
  }

  Future<ExperienceModel?> getById(String id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<ExperienceModel> create(ExperienceModel model) async {
    final response = await mainClient.apiExperiencePost(
      body: _toCreateBody(model),
    );
    return _fromDto(response.body!);
  }

  Future<ExperienceModel> update(ExperienceModel model) async {
    final response = await mainClient.apiExperienceIdPut(
      id: int.tryParse(model.id),
      body: _toUpdateBody(model),
    );
    return _fromDto(response.body!);
  }

  Future<void> delete(String id) async {
    await mainClient.apiExperienceIdDelete(
      id: int.tryParse(id),
    );
  }
}
