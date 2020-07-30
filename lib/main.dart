import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> dogImages = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('RandomGallery'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: dogImages.length,
        itemBuilder: (context , index) {
          return Container(
            constraints: BoxConstraints.tightFor(height: 150),
            child: Image.network(dogImages[index], fit: BoxFit.fitWidth),
          );
        },
      ),
    );
  }
}