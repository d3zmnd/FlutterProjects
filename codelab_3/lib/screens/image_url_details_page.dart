import 'package:flutter/material.dart';

class UrlDetailsPage extends StatelessWidget {
  const UrlDetailsPage({
    Key key, @required this.assetPath
    }) : assert(assetPath != null),
    super(key: key);

  final String assetPath;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details'),),
      body: Center(
        child: Image.network(assetPath),)
    );
  }
}