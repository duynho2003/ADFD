import 'package:color_boxes/utils/color_gen.dart';
import 'package:flutter/material.dart';

class StatefullBox extends StatefulWidget {
  const StatefullBox({super.key});

  @override
  State<StatefullBox> createState() => _StatefullBoxState();
}

class _StatefullBoxState extends State<StatefullBox> {
  final Color color = getMyColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      width: 96,
      height: 96,
      margin: EdgeInsets.all(8),
    );
  }
}
