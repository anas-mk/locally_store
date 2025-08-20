import 'package:flutter/material.dart';
import 'color.dart';

extension ProductColorParsing on ProductColorEntity {
  Color toColor() {
    try {
      String hex = hexCode.replaceAll('#', '');
      if (hex.length == 6) hex = 'FF$hex';
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.transparent;
    }
  }
}
