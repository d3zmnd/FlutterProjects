import 'package:flutter/material.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({
    @required this.assetPath,
    Key key
  }) : assert(assetPath != null),
  super(key: key);
  final String assetPath;
  
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(title: const Text('Details'),),
      body: Center(
        child: Image.asset(assetPath),)
    );
}

class UrlDetailsPage extends StatelessWidget {
  const UrlDetailsPage({
    @required this.assetPath,
    Key key
    }) : assert(assetPath != null),
    super(key: key);
  final String assetPath;
  
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(title: const Text('Details'),),
      body: Center(
        child: Image.network(assetPath),)
    );
  
}