import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pmsna1/models/trailer_model.dart';

class ApiTrailer {
  String id;
  late Uri link;

  ApiTrailer(this.id) {
    link = Uri.parse('https://api.themoviedb.org/3/movie/$id/videos?api_key=5019e68de7bc112f4e4337a500b96c56&append_to_response=videos');
  }

  Future<List<TrailerModel>?> getTrailer() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if( result.statusCode == 200 ){
      return listJSON.map((trailer) => TrailerModel.fromMap(trailer)).toList(); 
    }
    return null;
  }
}
