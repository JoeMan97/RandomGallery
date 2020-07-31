import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

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
  final List<String> images = new List();
  ScrollController _scrollController = new ScrollController();

  fetchImages() async {
    Response response = await get('https://dog.ceo/api/breeds/image/random');
    if (response.statusCode == 200) {
      setState(() {
        images.add(json.decode(response.body)['message']);
      });
    } else {
      throw Exception('No se pudo cargar la imágen');
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
        itemCount: images.length,
        itemBuilder: (context, index) => 
          Container(
            margin: EdgeInsets.only(top: 8),
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 16/9,
                autoPlayCurve: Curves.fastOutSlowIn,
                height: 165,
                enableInfiniteScroll: true,
                viewportFraction: 0.8
              ),
              items: <Widget>[
                Image.network('${images[index]}'),
              ],  
            ),
          )
      )
    );
  }
}