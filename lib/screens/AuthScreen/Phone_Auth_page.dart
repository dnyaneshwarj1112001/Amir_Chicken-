import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amir_chikan/cubit/auth_cubit.dart';
import 'package:amir_chikan/cubit/auth_state.dart';
import 'package:amir_chikan/presentation/Global_widget/custome_Next_button.dart';
import 'package:amir_chikan/features/auth/presentation/AuthScreen/Otp_verification_page.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'PhoneAuthScreen';

  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.response.message ?? 'OTP sent')),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpVerificationScreen(
                    phoneNumber: phoneController.text.trim(),
                    otp: state.response.otp.toString(),
                  ),
                ), 
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Get started",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your phone number',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      prefixText: '+91 ',
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      final phone = phoneController.text.toString();
                      if (phone.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid number'),
                          ),
                        );
                        return;
                      } else if (phone.length < 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid number'),
                          ),
                        );
                        return;
                      }
                      context.read<AuthCubit>().loginWithPhone(phone);
                    },
                    text: state is AuthLoading ? "Loading..." : "Sign In",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
