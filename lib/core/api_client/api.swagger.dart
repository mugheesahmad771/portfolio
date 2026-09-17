// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'api.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
export 'api.models.swagger.dart';

part 'api.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Api extends ChopperService {
  static Api create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Api(client);
    }

    final newClient = ChopperClient(
      services: [_$Api()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl ?? Uri.parse('http://'),
    );
    return _$Api(newClient);
  }

  ///
  Future<chopper.Response<LoginResponseDto>> apiAuthLoginPost({
    required LoginRequestModel? body,
  }) {
    generatedMapping.putIfAbsent(
      LoginResponseDto,
      () => LoginResponseDto.fromJsonFactory,
    );

    return _apiAuthLoginPost(body: body);
  }

  ///
  @POST(path: '/api/Auth/login', optionalBody: true)
  Future<chopper.Response<LoginResponseDto>> _apiAuthLoginPost({
    @Body() required LoginRequestModel? body,
  });

  ///
  Future<chopper.Response<LoginResponseDto>> apiAuthRefreshPost({
    required RefreshTokenRequestModel? body,
  }) {
    generatedMapping.putIfAbsent(
      LoginResponseDto,
      () => LoginResponseDto.fromJsonFactory,
    );

    return _apiAuthRefreshPost(body: body);
  }

  ///
  @POST(path: '/api/Auth/refresh', optionalBody: true)
  Future<chopper.Response<LoginResponseDto>> _apiAuthRefreshPost({
    @Body() required RefreshTokenRequestModel? body,
  });

  ///
  Future<chopper.Response<ContactSubmissionDto>> apiContactPost({
    required SubmitContactRequestModel? body,
  }) {
    generatedMapping.putIfAbsent(
      ContactSubmissionDto,
      () => ContactSubmissionDto.fromJsonFactory,
    );

    return _apiContactPost(body: body);
  }

  ///
  @POST(path: '/api/Contact', optionalBody: true)
  Future<chopper.Response<ContactSubmissionDto>> _apiContactPost({
    @Body() required SubmitContactRequestModel? body,
  });

  ///
  Future<chopper.Response<List<ContactSubmissionDto>>> apiContactGet() {
    generatedMapping.putIfAbsent(
      ContactSubmissionDto,
      () => ContactSubmissionDto.fromJsonFactory,
    );

    return _apiContactGet();
  }

  ///
  @GET(path: '/api/Contact')
  Future<chopper.Response<List<ContactSubmissionDto>>> _apiContactGet();

  ///
  Future<chopper.Response<List<ExperienceDto>>> apiExperienceGet() {
    generatedMapping.putIfAbsent(
      ExperienceDto,
      () => ExperienceDto.fromJsonFactory,
    );

    return _apiExperienceGet();
  }

  ///
  @GET(path: '/api/Experience')
  Future<chopper.Response<List<ExperienceDto>>> _apiExperienceGet();

  ///
  Future<chopper.Response<ExperienceDto>> apiExperiencePost({
    required CreateExperienceRequestModel? body,
  }) {
    generatedMapping.putIfAbsent(
      ExperienceDto,
      () => ExperienceDto.fromJsonFactory,
    );

    return _apiExperiencePost(body: body);
  }

  ///
  @POST(path: '/api/Experience', optionalBody: true)
  Future<chopper.Response<ExperienceDto>> _apiExperiencePost({
    @Body() required CreateExperienceRequestModel? body,
  });

  ///
  ///@param id
  Future<chopper.Response<ExperienceDto>> apiExperienceIdPut({
    required int? id,
    required UpdateExperienceRequestModel? body,
  }) {
    generatedMapping.putIfAbsent(
      ExperienceDto,
      () => ExperienceDto.fromJsonFactory,
    );

    return _apiExperienceIdPut(id: id, body: body);
  }

  ///
  ///@param id
  @PUT(path: '/api/Experience/{id}', optionalBody: true)
  Future<chopper.Response<ExperienceDto>> _apiExperienceIdPut({
    @Path('id') required int? id,
    @Body() required UpdateExperienceRequestModel? body,
  });

  ///
  ///@param id
  Future<chopper.Response> apiExperienceIdDelete({required int? id}) {
    return _apiExperienceIdDelete(id: id);
  }

  ///
  ///@param id
  @DELETE(path: '/api/Experience/{id}')
  Future<chopper.Response> _apiExperienceIdDelete({
    @Path('id') required int? id,
  });

  ///
  ///@param featured
  Future<chopper.Response<List<ProjectDto>>> apiProjectsGet({bool? featured}) {
    generatedMapping.putIfAbsent(ProjectDto, () => ProjectDto.fromJsonFactory);

    return _apiProjectsGet(featured: featured);
  }

  ///
  ///@param featured
  @GET(path: '/api/Projects')
  Future<chopper.Response<List<ProjectDto>>> _apiProjectsGet({
    @Query('featured') bool? featured,
  });

  ///
  Future<chopper.Response<ProjectDto>> apiProjectsPost({
    required CreateProjectRequestModel? body,
  }) {
    generatedMapping.putIfAbsent(ProjectDto, () => ProjectDto.fromJsonFactory);

    return _apiProjectsPost(body: body);
  }

  ///
  @POST(path: '/api/Projects', optionalBody: true)
  Future<chopper.Response<ProjectDto>> _apiProjectsPost({
    @Body() required CreateProjectRequestModel? body,
  });

  ///
  ///@param slug
  Future<chopper.Response<ProjectDto>> apiProjectsSlugGet({
    required String? slug,
  }) {
    generatedMapping.putIfAbsent(ProjectDto, () => ProjectDto.fromJsonFactory);

    return _apiProjectsSlugGet(slug: slug);
  }

  ///
  ///@param slug
  @GET(path: '/api/Projects/{slug}')
  Future<chopper.Response<ProjectDto>> _apiProjectsSlugGet({
    @Path('slug') required String? slug,
  });

  ///
  ///@param id
  Future<chopper.Response<ProjectDto>> apiProjectsIdPut({
    required int? id,
    required UpdateProjectRequestModel? body,
  }) {
    generatedMapping.putIfAbsent(ProjectDto, () => ProjectDto.fromJsonFactory);

    return _apiProjectsIdPut(id: id, body: body);
  }

  ///
  ///@param id
  @PUT(path: '/api/Projects/{id}', optionalBody: true)
  Future<chopper.Response<ProjectDto>> _apiProjectsIdPut({
    @Path('id') required int? id,
    @Body() required UpdateProjectRequestModel? body,
  });

  ///
  ///@param id
  Future<chopper.Response> apiProjectsIdDelete({required int? id}) {
    return _apiProjectsIdDelete(id: id);
  }

  ///
  ///@param id
  @DELETE(path: '/api/Projects/{id}')
  Future<chopper.Response> _apiProjectsIdDelete({@Path('id') required int? id});

  ///
  Future<chopper.Response> apiUploadsPost({List<int>? file}) {
    return _apiUploadsPost(file: file);
  }

  ///
  @POST(path: '/api/Uploads', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _apiUploadsPost({@PartFile() List<int>? file});
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
