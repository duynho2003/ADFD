import 'package:color_boxes/utils/color_gen.dart';
import 'package:flutter/material.dart';

class StatelessBox extends StatelessWidget {
  final Color color = getMyColor();
  StatelessBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, border: Border.all(color: Colors.black87)),
      height: 96,
      width: 96,
      margin: EdgeInsets.all(8),
    );
  }
}
