import 'dart:typed_data';
import 'package:http/http.dart' as http;

///Exception for CoffeeApi request failure
class CoffeeRequestFailure implements Exception {}

///Api that makes http requests to coffee.alexflipnote.dev
class CoffeeApi {
  ///CoffeeApi constructor
  CoffeeApi({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  static const _baseUrl = 'coffee.alexflipnote.dev';

  ///Make http get request to https://coffee.alexflipnote.dev/random and return json decoded body
  Future<Uint8List> getCoffeeImgBytes() async {
    final request = Uri.https(_baseUrl, 'random');

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) throw CoffeeRequestFailure();

    return response.bodyBytes;
  }
}
