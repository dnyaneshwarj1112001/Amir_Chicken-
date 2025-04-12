import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:flutter/material.dart';

class CustomiseDrawerandchip extends StatefulWidget {
  final String text;
  const CustomiseDrawerandchip({super.key, required this.text});

  @override
  State<CustomiseDrawerandchip> createState() => _CustomiseDrawerandchipState();
}

class _CustomiseDrawerandchipState extends State<CustomiseDrawerandchip> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Chip(
                label: Text(
                  widget.text,
                  style:  TextStyle(
                    color: Appcolor.primaryRed,
                    fontSize: 15,
                  ),
                ),
                shape: StadiumBorder(
                    side: BorderSide(color: Appcolor.primaryRed, width: 1.5)),
              )
            ],
          ),
        ),
        Builder(
          // ✅ Ensures the correct context for opening the drawer
          builder: (context) => IconButton(
            icon:  Icon(
              Icons.menu,
              color: Appcolor.primaryRed,
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ],
    );
  }
}
