import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPhotos {
  final List<Photo> photos = [];

  ListPhotos();

  fromResponse(http.Response response) {
    List jsonData = json.decode(response.body);
    Photo photo;

    jsonData.forEach((photoData) {
      photo = Photo(
        id: photoData['id'] ?? '',
        imgSmall: photoData['urls']['small'] ?? '',
        imgFull: photoData['urls']['full'] ?? '',
        description: photoData['description'] ?? '',
        authorName: photoData['user']['name'] ?? '',
        color: photoData['color'] ?? '',
      );

      photos.add(photo);
    });
  }
}

class Photo {
  String id;
  String imgSmall;
  String imgFull;
  String description;
  String authorName;
  Color color;

  Photo({this.id, this.imgSmall, this.imgFull, this.description, this.authorName,
      String color}) {
    this.color = color.isNotEmpty
        ? Color(int.parse(color.replaceFirst(new RegExp(r'#'), '0xff')))
        : Color(0xff222831);
  }
}
