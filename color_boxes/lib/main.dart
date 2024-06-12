import 'package:color_boxes/widgets/statefull_box.dart';
import 'package:color_boxes/widgets/stateless_box.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var statelessBoxes = <Widget>[StatelessBox(), StatelessBox()];
  var statefullBoxes = <Widget>[StatefullBox(), StatefullBox()];
  var statefullBoxesWithKey = <Widget>[
    StatefullBox(key: UniqueKey()), 
    StatefullBox(
      key: UniqueKey(),
    )
  ];

  var paddingstatefullBoxesWithKey = <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefullBox(key: UniqueKey()),
    ), 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefullBox(
        key: UniqueKey(),
      ),
    )
  ];

  void _swap() {
    setState(() {
      var box = statelessBoxes.removeAt(0);
      statelessBoxes.add(box);

      var box2 = statefullBoxes.removeAt(0);
      statefullBoxes.add(box2);
      
      var box3 = statefullBoxesWithKey.removeAt(0);
      statefullBoxesWithKey.add(box3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          Row(children: statelessBoxes),
          Divider(
            height: 24,
            thickness: 1.0,
            color: Colors.blueGrey,
          ),
          Row(children: statefullBoxes),
          Divider(
            height: 24,
            thickness: 1.0,
            color: Colors.blueGrey,
          ),
          Row(children: statefullBoxesWithKey),
          Divider(
            height: 24,
            thickness: 1.0,
            color: Colors.blueGrey,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (_swap),
        tooltip: 'Swap Boxes',
        child: const Icon(Icons.recycling_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
