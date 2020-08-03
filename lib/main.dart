import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_gallery/classes/dogs_images.dart';
import 'package:random_gallery/widgets/images_listview.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider<DogsImages>( 
        create: (context) => DogsImages(),
        child: Home(),
    ),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dogsImages = Provider.of<DogsImages>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('RandomGallery'),
        centerTitle: true,
      ),
      backgroundColor: Colors.indigo[50],
      body: ImagesListView(dogsImages: dogsImages),
    );
  }
}

