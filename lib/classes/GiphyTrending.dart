import 'GiphyRequest.dart';

class GiphyTrending {
  GiphyRequest _request;

  GiphyTrending() {
    _request = GiphyRequest.trending();
  }

  Future<Map> get bestGifs => _request.doSearch();

}