import 'package:amir_chikan/core/network/api_client.dart';
import 'package:amir_chikan/core/network/dio_client.dart';
import 'package:amir_chikan/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

 AuthCubit() : _authRepository = AuthRepository(ApiClient(DioClient.dio)), super(AuthInitial());

  void loginWithPhone(String phone) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.login(phone);
      print(
          "${response.toJson()}==================================================================================================1>>>>");
      emit(AuthSuccess(response: response));
    } catch (e) {
      print(e);
      emit(AuthFailure(message: e.toString()));
    }
  }
}
