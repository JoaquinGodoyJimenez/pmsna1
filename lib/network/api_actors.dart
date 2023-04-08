import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pmsna1/models/actors_model.dart';

class ApiActors {
  String id;
  late Uri link;
  
  ApiActors(this.id) {
    link = Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=5019e68de7bc112f4e4337a500b96c56');
  }

  Future<List<ActorsModel>?> getAllActors() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['cast'] as List;
    if( result.statusCode == 200 ){
      return listJSON.map((actors) => ActorsModel.fromMap(actors)).toList(); 
    }
    return null;
  }
}