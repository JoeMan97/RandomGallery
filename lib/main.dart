import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:random_gallery/screensize_reducers.dart';
import 'package:random_gallery/dogs_images.dart';

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
  DogsImages dogsImages = new DogsImages();
  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      dogsImages.fetchTwelve();  
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          dogsImages.fetchTwelve();  
        });
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
        itemCount: dogsImages.images.length,
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
              dogsImages.images[index].map((image) => 
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