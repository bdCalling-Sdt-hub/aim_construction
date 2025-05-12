import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SvgPicture

class ToolsCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  // Constructor to initialize the title, icon path, and tap action
  const ToolsCard({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 73.0,
            height: 73.0,
            decoration: BoxDecoration(
              color: Color(0xFFEBECEE),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: SvgPicture.asset(icon),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF323B4A),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }}