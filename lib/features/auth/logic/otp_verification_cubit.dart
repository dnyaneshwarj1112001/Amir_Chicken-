import 'package:amir_chikan/data/repositories/auth_repository.dart';

import 'package:amir_chikan/features/auth/logic/otp_verification_state';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Otpverificationcubit extends Cubit<OtpVerificationState> {
  final AuthRepository authRepository;

  Otpverificationcubit(this.authRepository) : super(OtpVerificationInitial());
  void verifyOtp(String PhoneNumber, String otp) async {
    emit(OtpVerificationLoading());
    try {
      final response = await authRepository.VerifyOtp(PhoneNumber, otp);
      if (!response.hasError) {
        emit(OtpVerificationSuccess(response: response));
      } else {
        emit(OtpVerificationFailure(error: "errorMessage));"));
      }
    } catch (e) {
      if (e is DioError) {
        emit(OtpVerificationFailure(error: e.toString()));
      } else {
        emit(OtpVerificationFailure(error: "An unexpected error occurred."));
      }
    }
  }
}
