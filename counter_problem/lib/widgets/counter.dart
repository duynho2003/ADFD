import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget(
      {super.key, required int counter, required bool isLoading})
      : _counter = counter,
        _isLoading = isLoading;

  final int _counter;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    var message = '';
    if (_counter <= 0) {
      message = 'Begin count';
    } else if (_counter < 10) {
      message = 'Keep counting';
    } else if (_counter < 100) {
      message = 'Good counting';
    } else if (_counter < 1000) {
      message = 'Very patient!';
    }
    return Text(
      '$message : $_counter',
    );
  }
}
