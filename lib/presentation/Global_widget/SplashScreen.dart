import 'dart:async';

import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/presentation/Global_widget/Onbording%20Screen/preScreens.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigatePage() {
    Timer(Duration(seconds: 4), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnbordingScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    navigatePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9C141C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 260,
              width: 260,
              child: Image.asset("lib/innitiel_screens/images/Murga.png"),
            ),
          ),
          const Text("meatzo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontFamily: 'KaushanScript',
              )),
          Gaph(
            height: 10,
          ),
          const Text("Order Meat From Apni Dukan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'KaushanScript',
              ))
        ],
      ),
    );
  }
}
