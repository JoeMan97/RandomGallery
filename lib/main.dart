import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:random_gallery/screensize_reducers.dart';

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
  List<List<String>> images = new List();
  ScrollController _scrollController = new ScrollController();

  fetchImages(int index) async {
    List<String> imagesAux = new List(3);

    Response response1 = await get('https://dog.ceo/api/breeds/image/random');
    Response response2 = await get('https://dog.ceo/api/breeds/image/random');
    Response response3 = await get('https://dog.ceo/api/breeds/image/random');
    if (response1.statusCode == 200 && response2.statusCode == 200 && response3.statusCode == 200) {
      setState(() {
        imagesAux[0] = (json.decode(response1.body)['message']);
        imagesAux[1] = (json.decode(response2.body)['message']);
        imagesAux[2] = (json.decode(response3.body)['message']);
      });
    } else {
      throw Exception('No se pudo cargar la imágen');
    }

    images.add(imagesAux);
  }

  fetchTwelve() {
    for (int i = 0; i < 4; i++) {
      fetchImages(i);
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

    fetchTwelve();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchTwelve();
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
                height: 
                ScreensizeReducers().screenHeightExcludingToolbar(
                  context,
                  dividedBy: 4
                ) - 12.0, // no se activa el evento si coloco 16
                enableInfiniteScroll: true,
                viewportFraction: 0.8
              ),
              items: 
              images[index].map((image) => 
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network('$image')
                ),
              ).toList()
            ),
          )
      )
    );
  }
}