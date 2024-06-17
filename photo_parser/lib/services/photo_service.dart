import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:photo_parser/apis/endpoint.dart';
import '../models/photos.dart';

List<Photo> parsePhoto(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json));
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse(Endpoint.photoList));

  return compute(parsePhoto, response.body);
}
