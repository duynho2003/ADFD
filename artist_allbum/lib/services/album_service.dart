import 'dart:convert';
import 'package:artist_allbum/constant/apis.dart';
import 'package:artist_allbum/models/album.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  var response = await http.get(Uri.parse(ablumApi));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  }
  return throw Exception('Failed to load album');
}

Future<Album> createAlbum(String title) async {
  var response = await http.post(
    Uri.parse(createAlbumApi),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String> {
      'title': title
    })
  );

  print(response.body);

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  }
  return throw Exception('Failed to load album');
}

Future<Album> updateAlbum(String title) async {
  var response = await http.put(
    Uri.parse(createAlbumApi),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String> {
      'title': title
    })
  );

  print(response.body);

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  }
  return throw Exception('Failed to load album');
}

Future<Album> deleteAlbum(int id) async {
  var response = await http.delete(Uri.parse(deleteAlbumApi + id.toString()));

  print(response.body);

  if (response.statusCode == 200) {
    return Album(userId: 0, id: 0, title: 'delete');
  }
  return throw Exception('Failed to delete album');
}


