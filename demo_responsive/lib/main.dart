import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Responsive Example'),
        ),
        body: ResponsiveWidget(
          desktopWidget: DesktopWidget(),
          tabletWidget: TabletWidget(),
          mobileWidget: MobileWidget(),
        ),
      ),
    );
  }
}

class ResponsiveWidget extends StatelessWidget {
  final Widget desktopWidget;
  final Widget tabletWidget;
  final Widget mobileWidget;

  ResponsiveWidget(
      {required this.desktopWidget,
      required this.tabletWidget,
      required this.mobileWidget});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return desktopWidget;
        } else if (constraints.maxWidth > 600 && constraints.maxWidth <= 1024) {
          return tabletWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}

class DesktopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 200,
        color: Colors.blue,
        child: Text(
          'Desktop',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class TabletWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 150,
        color: Colors.green,
        child: Text(
          'Tablet',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class MobileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 100,
        color: Colors.orange,
        child: Text(
          'Mobile',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}