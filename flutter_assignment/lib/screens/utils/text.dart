import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final double fontSize;
  const HeadingText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CommonText extends StatelessWidget {
  final String text;
  final Color? color;
  const CommonText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      text,
      style: TextStyle(
        fontSize: screenHeight * 0.018,
        color: color ?? const Color(0xffE1E1E5),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
