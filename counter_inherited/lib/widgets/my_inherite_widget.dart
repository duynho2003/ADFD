import 'package:flutter/material.dart';

class MyInheriteWidget extends InheritedWidget {
  final int counter;
  final bool isLoading;

  const MyInheriteWidget(
      {super.key,
      required super.child,
      required this.counter,
      required this.isLoading});

  @override
  bool updateShouldNotify(covariant MyInheriteWidget oldWidget) {
    return isLoading != oldWidget.isLoading || counter != oldWidget.counter;
  }

  static MyInheriteWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheriteWidget>();
  }
}
