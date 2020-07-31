import 'dart:convert';
import 'package:http/http.dart';

class DogsImages {
  List<List<String>> images = new List();

  _fetchImages(int index) async {
    List<String> imagesAux = new List(3);

    Response response1 = await get('https://dog.ceo/api/breeds/image/random');
    Response response2 = await get('https://dog.ceo/api/breeds/image/random');
    Response response3 = await get('https://dog.ceo/api/breeds/image/random');
    if (response1.statusCode == 200 && response2.statusCode == 200 && response3.statusCode == 200) {
      imagesAux[0] = (json.decode(response1.body)['message']);
      imagesAux[1] = (json.decode(response2.body)['message']);
      imagesAux[2] = (json.decode(response3.body)['message']);
    } else {
      throw Exception('No se pudo cargar la imágen');
    }

    images.add(imagesAux);
  }

  fetchTwelve() {
    for (int i = 0; i < 4; i++) {
      _fetchImages(i);
    }
  }
}