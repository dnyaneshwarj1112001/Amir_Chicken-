import 'package:amir_chikan/core/network/api_client.dart';
import 'package:amir_chikan/data/models/auth_response_model.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<AuthResponseModel> login(String phoneNumber) {
    return apiClient.login({"mobile_number": phoneNumber});
  }
}
