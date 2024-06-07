import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData _appTheme = ThemeData(
    brightness : Brightness.light, 
    primaryColor : Colors.blue, 
    fontFamily : 'Roboto', 
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange),
    useMaterial3: false);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TextFieldExample(),
    );
  }
}

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Controller'),
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(20.0), child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter you text'),
          ),
          const SizedBox(height: 20.0,),
          ElevatedButton(onPressed: () {
            final enteredtext = _controller.text;
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: const Text('You entered'),
                content: Text(enteredtext),
                actions: <Widget>[
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text('Close'))
                ],
              );
            });
          }, 
          child: const Text('Show Entered Text'))
        ],
        ),),),
    );
  }
}