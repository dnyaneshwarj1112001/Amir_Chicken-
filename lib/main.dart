import 'package:amir_chikan/internet/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/screens/Mycart/cubit/counter_cubit_cubit.dart';
import 'package:amir_chikan/core/network/api_client.dart';
import 'package:amir_chikan/presentation/Global_widget/app_routes.dart';
import 'package:amir_chikan/presentation/Global_widget/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubitCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(),
        ),
        initialRoute: AppRoutes.nav,
        routes: AppRoutes.routes,
      ),
    );
  }
}
