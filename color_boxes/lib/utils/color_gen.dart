import 'dart:math';

import 'package:flutter/material.dart';

Color getMyColor(){
  final Random random = Random();
  return Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
}