import 'package:flutter/material.dart';
import 'package:gallery_app/screens/image_details_page.dart';
import 'package:gallery_app/screens/image_url_details_page.dart';

class MyHomePage extends StatefulWidget {
  
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final list = [''];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final images = <String>[
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
    'resources/paulfuentes/12.jpg',];
  final urls = <String>[
    'https://picsum.photos/id/555/200/300',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/id/698/200/300',
    'https://picsum.photos/id/740/200/300',
    'https://picsum.photos/200/300?random=1',
    'https://picsum.photos/id/340/200/300',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/id/240/200/300',
    'https://picsum.photos/id/140/200/300',
    'https://picsum.photos/200/300?random=1',
    ];
  int counter = 0;

  dynamic fullScreenImage(int index)=> Navigator.push(context,MaterialPageRoute<dynamic>(builder:(context) => ImageDetailsPage(assetPath: images[index])));
  
  dynamic renderImage(){
    setState(() {
      if (counter!= images.length){
        counter++;
      }
      else{
        print(counter);
      }
    });    
  }  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.image)),
            Tab(icon: Icon(Icons.network_wifi)),
          ],
        ),
        title: Text(widget.title),
      ),
      body: TabBarView(
        children: [
          assetsGallery(),
          urlGallery()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: renderImage,
        tooltip: 'Add image',
        child: Icon(Icons.add)
      ),
    );
  }

  Widget assetsGallery(){
    return GridView.builder(
      itemCount: counter,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(2.5),
          child: Center(
            child: Ink.image(
              image: AssetImage(images[index]), 
              fit: BoxFit.cover,
                child: InkWell(onTap: ()=> fullScreenImage(index)),
            ),
          ),
        );
      },
    );
  }

  Widget urlGallery(){
    return GridView.builder(
      itemCount: urls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(2.5),
          child: Center(
            child: InkWell(
              child: Image.network(urls[index]),
              onTap: ()=> Navigator.push(context,MaterialPageRoute<dynamic>(builder:(context) => UrlDetailsPage(assetPath: urls[index]))),
            ),
          ),
        );
      },
    );
  }
}