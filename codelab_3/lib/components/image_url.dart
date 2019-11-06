import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/screens/image_details_page.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final http.Response response = await client.get('https://jsonplaceholder.typicode.com/photos');
  return compute(parsePhotos, response.body);
}
List<Photo> parsePhotos(String responseBody) {
  final dynamic parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((dynamic json) => Photo.fromJson(json)).toList();
}
class Photo {
  Photo({this.url, this.thumbnailUrl});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
  final String url;
  final String thumbnailUrl;
}

class GalleryUrl extends StatelessWidget {
  const GalleryUrl({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: fetchPhotos(http.Client()),
      builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        return snapshot.hasData
          ? PhotosList(photos: snapshot.data)
          : Center(child: const CircularProgressIndicator());
      },
    );
  }
}
class PhotosList extends StatelessWidget {
  const PhotosList({Key key, this.photos}) : super(key: key);
  final List<Photo> photos;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4 ,
      ),
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(2.5),
          child: Center(
            child: InkWell(
              child: Image.network(photos[index].thumbnailUrl),
              onTap: ()=> Navigator.push(context, MaterialPageRoute<dynamic>(builder:(BuildContext context) => UrlDetailsPage(assetPath: photos[index].url))),
            ),
          ),
        );
      },
    );
  }
}
