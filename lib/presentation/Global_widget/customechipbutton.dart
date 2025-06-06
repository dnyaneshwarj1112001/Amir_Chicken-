import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  final String text; // Text on the chip button
  final VoidCallback onPressed; // Action to perform on chip press

  const CustomChipButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xff9a292f), // Background color
          borderRadius: BorderRadius.circular(20), // Rounded edges
          border: Border.all(color: Colors.white, width: 1), // Border
        ),
        child: Apptext(
          text: text,
          color: Colors.white,
          size: 10, // Small text size
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
