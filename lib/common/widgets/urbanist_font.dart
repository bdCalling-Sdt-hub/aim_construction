import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrbanistFont extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;

  UrbanistFont({
    super.key,
    required this.title,
    this.fontSize=14,
    this.fontWeight=FontWeight.w400,
    this.color=Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: GoogleFonts.urbanist(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
