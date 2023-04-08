import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pmsna1/models/popular_model.dart';

class ApiPopular {
  
  Uri link = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if( result.statusCode == 200 ){
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList(); 
    }
    return null;
  }
}