import 'package:get/get.dart';
import 'package:portfolio/core/api_client/client_index.dart';
import 'package:portfolio/core/api_client/main_client.dart';

class ContactService extends GetxService {
  Future<void> submit(String name, String email, String message) async {
    await mainClient.apiContactPost(
      body: SubmitContactRequestModel(
        name: name,
        email: email,
        message: message,
      ),
    );
  }

  /// Auth-required admin inbox (rendered by `_buildMessagesTab` in
  /// admin_dashboard_page.dart). Returns raw maps — via
  /// [ContactSubmissionDto.toJson] — rather than a typed model, since
  /// that's what the existing admin UI already reads (`m['name']`,
  /// `m['submittedAtUtc']`, etc.).
  Future<List<Map<String, dynamic>>> getSubmissions() async {
    final response = await mainClient.apiContactGet();
    return (response.body ?? const []).map((dto) => dto.toJson()).toList();
  }
}
