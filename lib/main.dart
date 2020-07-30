import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
  ScrollController _scrollController = new ScrollController();

  fetchImages() async {
    Response response = await get('https://dog.ceo/api/breeds/image/random');
    if (response.statusCode == 200) {
      setState(() {
        dogImages.add(json.decode(response.body)['message']);
      });
    } else {
      throw Exception('No se pudo cargar las imágenes');
    }
  }

  fetchFour() {
    for (int i = 0; i < 4; i++) {
      fetchImages();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchFour();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchFour();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('RandomGallery'),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: dogImages.length,
        itemBuilder: (context , index) {
          return Container(
            constraints: BoxConstraints.tightFor(height: 200),
            child: Image.network(dogImages[index], fit: BoxFit.fitWidth),
          );
        },
      ),
    );
  }
}