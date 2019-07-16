import 'GiphyRequest.dart';

class GiphySearch {
  String _language, _url;

  GiphySearch(String query, int offset) {
    this._language = "en";
    this._url = "https://api.giphy.com/v1/gifs/search?api_key=${GiphyRequest.key}&q=$query&limit=19&offset=$offset&rating=G&lang=$_language";
  }

  get url => this._url;
}