import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pmsna1/models/cat_model.dart';

class ApiCat {
  Uri link = Uri.parse('https://api.thecatapi.com/v1/breeds');

  Future<List<CatModel>?> getCats() async {
    try {
      final response = await http.get(link);

      if (response.statusCode == 200) {
        final List<dynamic> catsJson = json.decode(response.body);
        final List<CatModel> cats = catsJson.map((catJson) => CatModel.fromJson(catJson)).toList();
        return cats;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}