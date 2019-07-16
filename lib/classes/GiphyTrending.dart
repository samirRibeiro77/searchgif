import 'GiphyRequest.dart';

class GiphyTrending extends GiphyRequest{
  String _url;

  GiphyTrending() {
    this._url = "https://api.giphy.com/v1/gifs/trending?api_key=${GiphyRequest.key}&limit=20&rating=G";
  }

  get url => this._url;
}