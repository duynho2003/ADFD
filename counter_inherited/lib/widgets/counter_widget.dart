import 'package:flutter/material.dart';
import 'package:counter_inherited/widgets/my_inherite_widget.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'You have pushed the button this many times:',
        ),
        DisplayCounterWidget(),
      ],
    );
  }
}

class DisplayCounterWidget extends StatelessWidget {
  const DisplayCounterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final myInheriteWidget = MyInheriteWidget.of(context);

    if (myInheriteWidget == null) {
      return const Text('MyInheritedWidget was not found');
    }

    return myInheriteWidget.isLoading
        ? const CircularProgressIndicator()
        : Text('${myInheriteWidget.counter}');
  }
}
