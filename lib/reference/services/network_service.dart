import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plantholic/reference/models/photo_model.dart';
// import '../api_key.dart';

class NetworkService {
  Future<List<PhotoModel>> fetchPhotos(String searchQuery) async {
    var url = Uri.parse(searchQuery == ""
        ? 'https://api.pexels.com/v1/curated?per_page=200'
        : "https://api.pexels.com/v1/search?query=$searchQuery&per_page=200");
    final response = await http.get(url, headers: {
      "Authorization":
          '563492ad6f91700001000001e1f92faca47d43e3921d8be0091f71af'
    }); //TODO: replace apiKey with your own API key

    return parsePhotos(response.body);
  }

  List<PhotoModel> parsePhotos(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed['photos']
        .map<PhotoModel>((json) => PhotoModel.fromJson(json))
        .toList();
  }
}
