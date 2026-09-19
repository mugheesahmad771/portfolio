import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/core/constants/api_constant.dart';
import 'package:portfolio/core/global/global_helpers.dart';
import 'package:portfolio/core/models/audit_log_model.dart';

/// Hand-written rather than going through the generated Chopper [mainClient]
/// — regenerating `api.*.swagger.dart` needs the swagger codegen tool
/// pointed at a running backend instance, and this is a single read-only
/// GET, so a plain http call is the smaller, safer change.
class AuditLogService extends GetxService {
  String get _baseUrl => production ? apiProdBase : apiDebugBase;

  Future<List<AuditLogModel>> getAll({int page = 1, int pageSize = 100}) async {
    final uri = Uri.parse(
      '$_baseUrl/api/AuditLogs?page=$page&pageSize=$pageSize',
    );
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${sessionHelper.accessToken ?? ''}'},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to load audit log (${response.statusCode}).');
    }

    final body = jsonDecode(response.body) as List<dynamic>;
    return body
        .map((e) => AuditLogModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
