import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/dogs_images.dart';
import '../classes/screensize_reducers.dart';

class ImagesListView extends StatefulWidget {
  final DogsImages dogsImages;

  ImagesListView({Key key, this.dogsImages}) : super(key: key);

  @override
  _ImagesListViewState createState() => _ImagesListViewState();
}

class _ImagesListViewState extends State<ImagesListView> {
  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.dogsImages.fetchTwelve();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        widget.dogsImages.fetchTwelve();  
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<DogsImages>(
      builder: (context, dogsImages, child) =>
      ListView.builder(
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
      ),
    );
  }
}