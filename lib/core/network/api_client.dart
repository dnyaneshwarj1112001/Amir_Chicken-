import 'package:amir_chikan/data/models/verify_Otp_ResponseModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:amir_chikan/data/models/auth_response_model.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/login")
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  @POST("/verify-otp")
  Future<VerifyOtpResponse>verifyOtp(@Body()Map<String,dynamic>body);

}
