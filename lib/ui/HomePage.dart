import 'package:flutter/material.dart';
import 'package:search_gif/classes/Giphy.dart';
import 'package:search_gif/classes/GiphyTrending.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Widget _searching() {
  return Container(
    width: 200.0,
    height: 200.0,
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 5.0,
    ),
  );
}

Widget _searchFinished(BuildContext context, AsyncSnapshot snapshot) {
  if (snapshot.hasError) return Container();
  return _createGifTable(context, snapshot);
}

Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
  return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: snapshot.data["data"].length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemBuilder: (context, index) {
        return _getImageByIndex(context, Giphy(snapshot.data["data"][index]));
      });
}

Widget _getImageByIndex(BuildContext context, Giphy item) {
  return GestureDetector(
    child: Image.network(item.gifPreview, height: 300.0, fit: BoxFit.cover,),

  );
}

class _HomePageState extends State<HomePage> {
  var trending = GiphyTrending();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: "Search",
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              )),
          Expanded(
            child: FutureBuilder(
                future: trending.bestGifs,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return _searching();
                    default:
                      return _searchFinished(context, snapshot);
                  }
                }),
          )
        ],
      ),
    );
  }
}
