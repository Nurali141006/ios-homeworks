import 'package:flutter/material.dart';

class CategoryTag extends StatelessWidget {
  final String label;
  final bool isMain;

  const CategoryTag({super.key, required this.label, this.isMain = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isMain ? Colors.deepOrange : const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isMain ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}