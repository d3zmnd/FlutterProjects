import 'dart:io';
import 'package:device_camera/components/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({Key key, this.place}) : super(key: key);

  final FavoritePlace place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(place.photo),
      title: Text(
        place.name,
        style: Theme.of(context).textTheme.subhead,
        maxLines: 1,
      ),
      subtitle: Text(
        place.description,
        style: Theme.of(context).textTheme.subtitle,
        maxLines: 1,
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FavoritePlace> places = <FavoritePlace>[];
  File photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson 5'),        
      ),
      body: places.isEmpty
        ? Center(
            child: const Text('Press + to add a new place.'),
          )
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) {
              return PlaceTile(place: places[index]);
            },
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _showCreatePlace(context),
      ),
    );
  }
  
  Future<dynamic> getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      photo = image;
    });
  }
  Future<dynamic> _showCreatePlace(BuildContext context) async {
    final FavoritePlace result = await Navigator.push(
    context,
    MaterialPageRoute<FavoritePlace>(
        builder: (BuildContext context) => CreatePlacePage()));
    if (result != null) {
      setState(() {
        places.add(result);
      });
    }
  }
}
