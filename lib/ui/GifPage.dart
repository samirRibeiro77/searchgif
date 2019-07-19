import 'package:flutter/material.dart';
import 'package:search_gif/classes/Giphy.dart';
import 'package:search_gif/classes/GiphyShare.dart';

class GifPage extends StatelessWidget {
  Giphy _giphy;

  GifPage(this._giphy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_giphy.title),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              GiphyShare.share(context, _giphy);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(child: Image.network(_giphy.gifFixedHeight)),
    );
  }
}
