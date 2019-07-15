import 'package:http/http.dart' as http;
import 'dart:convert';

class GiphyRequest {
  String _url;
  final _key = "U7QdYyq0nRyRvi0s6qyL2zvvanN3nrrS";

  GiphyRequest.trending(){
    _url = "https://api.giphy.com/v1/gifs/trending?api_key=$_key&limit=20&rating=G";
  }

  GiphyRequest.search(String query, int offset, String language){
    _url = "https://api.giphy.com/v1/gifs/search?api_key=$_key&q=$query&limit=20&offset=$offset&rating=G&lang=$language";
  }

  Future<Map> doSearch() async {
    http.Response response = await http.get(_url);
    return json.decode(response.body);
  }
}