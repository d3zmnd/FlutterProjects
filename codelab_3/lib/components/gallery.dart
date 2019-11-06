import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/screens/image_details_page.dart';
import 'package:gallery_app/components/image_url.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final List<String> list = <String>[''];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> images = <String>[
    'resources/paulfuentes/1.jpg',
    'resources/paulfuentes/2.jpg',
    'resources/paulfuentes/3.jpg',
    'resources/paulfuentes/4.jpg',
    'resources/paulfuentes/5.jpg',
    'resources/paulfuentes/6.jpg',
    'resources/paulfuentes/7.jpg',
    'resources/paulfuentes/8.jpg',
    'resources/paulfuentes/9.jpg',
    'resources/paulfuentes/10.jpg',
    'resources/paulfuentes/11.jpg',
    'resources/paulfuentes/12.jpg',
  ];
  int counter = 0;

  dynamic fullScreenImage(int index) => Navigator.push(
    context,
    MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>
          ImageDetailsPage(assetPath: images[index])));
  dynamic renderImage() {
      setState(() => counter != images.length 
      ? counter++ 
      : print(counter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.image)),
            Tab(icon: Icon(Icons.network_wifi)),
          ],
        ),
        title: Center(
          child: 
          const Text('Gallery')
        ),
      ),
      body: OrientationBuilder(builder: (BuildContext context, Orientation orientation) => TabBarView(
          children: <Widget>[
            assetsGallery(),
            const GalleryUrl(),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: renderImage, 
        tooltip: 'Add image', child: Icon(Icons.add)
      ),
    );
  }
  Widget assetsGallery() {
    return GridView.builder(
      itemCount: counter,
      gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4 ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(2.5),
          child: Center(
            child: Ink.image(
              image: AssetImage(images[index]),
              fit: BoxFit.cover,
              child: InkWell(onTap: () => fullScreenImage(index)),
            ),
          ),
        );
      },
    );
  }
}


