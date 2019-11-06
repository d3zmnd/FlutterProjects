import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FavoritePlace {
  FavoritePlace(this.name, this.description, this.photo);

  final File photo;
  final String name;
  final String description;
}
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
class CreatePlacePage extends StatefulWidget {
  @override
  _CreatePlacePageState createState() => _CreatePlacePageState();
}

class _CreatePlacePageState extends State<CreatePlacePage> {
  File _photo;
  String _placeName = '';
  String _placeDescription = '';

  Future<dynamic> _getPhoto() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    return setState(() {
      _photo = image;
    });
  }
  
  Future<dynamic> _selectPhoto() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return setState(() {
      _photo = image;
    });
  }
  void _save(BuildContext context) {
    if (_photo == null || _placeDescription.isEmpty || _placeName.isEmpty) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Photo, place name and place description must be specified.'),
          backgroundColor: Theme.of(context).accentColor,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      final FavoritePlace place = FavoritePlace(_placeName, _placeDescription, _photo);
      Navigator.pop(context, place);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your favourite place'),
      ),
      body:  Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                if (_photo != null) Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Image.file(_photo),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    labelText: 'Enter picture name'),
                  onChanged: (String text) {
                    _placeName = text;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    labelText: 'Enter desciption'),
                  onChanged: (String text) {
                    _placeDescription = text;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buttonSelect(),
                    buttonGet(),
                    buttonCreate()                    
                  ]
                ),
              ],
            ),
          ),
        );
      }
      )
    );
  }

   dynamic buttonGet() => RaisedButton(
      child: const Text('Select picture'),
      onPressed: ()  => _getPhoto(),
      textColor: Colors.white,
      color: Colors.deepOrangeAccent,                    
    );
  dynamic buttonSelect(){
    return RaisedButton(
      child: const Text('Take picture'),
      onPressed: ()  => _selectPhoto(),
      textColor: Colors.white,
      color: Colors.deepOrangeAccent,                    
    );
  }
  dynamic buttonCreate(){
    return  RaisedButton(
      child: const Text('Create'),
      onPressed: () =>_save(context),
      textColor: Colors.white,
      color: Colors.red[900],
    );
  }
}