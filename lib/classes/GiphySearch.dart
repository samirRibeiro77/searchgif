import 'GiphyRequest.dart';

class GiphySearch {
  GiphyRequest _request;
  String _query;
  int _offset;
  String _language;

  GiphySearch(this._query, this._language) {
    this._offset = 20;
    _request = GiphyRequest.search(_query, _offset, _language);
  }

  Future<Map> get searchGifs => _request.doSearch();
}