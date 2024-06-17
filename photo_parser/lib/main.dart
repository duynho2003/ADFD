import 'package:flutter/material.dart';
import 'package:photo_parser/models/photos.dart';
import 'package:photo_parser/services/photo_service.dart';
import 'package:http/http.dart' as http;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Photo>>(
          future: fetchPhotos(http.Client()),
          builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Cannot fetch data. Try again'));
            } else if (snapshot.hasData && snapshot.data != null) {
              return PhotoGridView(snapshot.data!);
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

class PhotoGridView extends StatelessWidget {
  final List<Photo> photos;

  const PhotoGridView(this.photos, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 8, // Spacing between rows
        crossAxisSpacing: 8, // Spacing between columns
        childAspectRatio: 0.8, // Adjust aspect ratio if needed
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return PhotoGridItem(photo); 
      },
    );
  }
}

class PhotoGridItem extends StatelessWidget {
  final Photo photo;

  const PhotoGridItem(this.photo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Image.network(
              photo.url, 
              height: 100,  // Adjust height as needed
              width: 100,  // Adjust width as needed
              fit: BoxFit.cover, // Ensures the image fills the space
            ),
            const SizedBox(height: 8),
            Text(
              photo.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12), // Adjust font size if needed
            ),
          ],
        ),
      ),
    );
  }
}
