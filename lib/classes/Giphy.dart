class Giphy {
  String _title;
  Map<String, String> _images;

  Giphy(Map values) {
    this._title = values["title"];
    this._images = Map();
    _images["fixed_height"] = values["images"]["fixed_height"]["url"];
    _images["fixed_height_small"] = values["images"]["fixed_height_small"]["url"];
  }
  
  get title => _title;
  get gifFixedHeight => _images["fixed_height"];
  get gifPreview => _images["fixed_height_small"];
}