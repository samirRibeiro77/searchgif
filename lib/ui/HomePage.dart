import 'package:flutter/material.dart';
import 'package:search_gif/classes/Giphy.dart';
import 'package:search_gif/classes/GiphyShare.dart';
import 'package:search_gif/classes/GiphyTrending.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:search_gif/classes/GiphySearch.dart';
import 'package:transparent_image/transparent_image.dart';
import 'GifPage.dart';

String _query;
int _offset;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> _searchGifs() async {
    http.Response response;

    if (_query == null || _query.isEmpty) {
      var giphy = GiphyTrending();
      response = await http.get(giphy.url);
    } else {
      var giphy = GiphySearch(_query, _offset);
      response = await http.get(giphy.url);
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    _searchGifs().then((map) {
      print(map);
    });
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
    if (snapshot.hasError || snapshot.data == null) return Container();
    return _createGifTable(context, snapshot);
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: _getCount(snapshot.data["data"]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemBuilder: (context, index) {
          return _getImageByIndex(context, snapshot.data["data"], index,
              snapshot.data["data"].length);
        });
  }

  Widget _getImageByIndex(
      BuildContext context, snapshotData, int index, int length) {
    if (_query == null || _query.isEmpty || index < length) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GifPage(Giphy(snapshotData[index]))));
          },
          onLongPress: () {
            GiphyShare.share(context, Giphy(snapshotData[index]));
          },
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: Giphy(snapshotData[index]).gifPreview,
              height: 300.0,
              fit: BoxFit.cover));
    } else {
      return Container(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _offset += 19;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add, color: Colors.white, size: 70.0),
              Text("Load more...",
                  style: TextStyle(color: Colors.white, fontSize: 22.0))
            ],
          ),
        ),
      );
    }
  }

  int _getCount(List data) {
    if (_query == null || _query.isEmpty) {
      return data.length;
    }

    return data.length + 1;
  }

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
                onChanged: (text) {
                  setState(() {
                    _query = text;
                    _offset = 0;
                  });
                },
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
                future: _searchGifs(),
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
