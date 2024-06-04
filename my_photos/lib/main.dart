import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PhotoGridScreen(),
    );
  }
}

class PhotoGridScreen extends StatefulWidget {
  @override
  _PhotoGridScreenState createState() => _PhotoGridScreenState();
}

class _PhotoGridScreenState extends State<PhotoGridScreen> {
  List<XFile> _images = []; // Store selected image files

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile);
      });
    }
  }

  Future<File> _saveImageToTemporaryDirectory(XFile image) async {
    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create a unique file name for the temporary image
    final fileName = p.basename(image.path); // Extract original file name
    final tempFilePath = p.join(tempDir.path, fileName);

    // Copy the image to the temporary directory
    return await File(image.path).copy(tempFilePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid List'),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2, // Number of columns in the grid
        itemCount: _images.length,
        itemBuilder: (BuildContext context, int index) => FutureBuilder<File>(
          future: _saveImageToTemporaryDirectory(_images[index]), // Correctly save XFile
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading image')); // Handle errors
            } else {
              return GestureDetector(
                onTap: () {
                  // Handle image tap (e.g., open full-screen viewer)
                },
                child: Hero(
                  tag: 'imageHero-${_images[index].name}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
          },
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.count(
            1, index.isEven ? 1.2 : 1.8), // Varying tile heights
        mainAxisSpacing: 8.0, // Spacing between items on the main axis
        crossAxisSpacing: 8.0, // Spacing between items on the cross axis
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add),
      ),
    );
  }
}
