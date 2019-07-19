import 'package:flutter/material.dart';
import 'Giphy.dart';
import 'package:http/http.dart' as http;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:flutter/services.dart';

class GiphyShare {
  static void share(BuildContext context, Giphy giphy) async {
    _isDownlaoding(context, true);
    print("Downloading: ${giphy.gifFixedHeight}");
    var response = await http.get(giphy.gifFixedHeight);
    var filePath =
        await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    print("FilePath: $filePath");
    _isDownlaoding(context, false);

    String BASE64_IMAGE = filePath;
    final ByteData bytes = await rootBundle.load(BASE64_IMAGE);
    await EsysFlutterShare.shareImage("giphy.gif", bytes, "Test");
  }

  static void _isDownlaoding(BuildContext context, bool running) {
    if (running) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Donwloading gif...",
                        style: TextStyle(color: Colors.black, fontSize: 22.0)),
                  )
                ],
              )
            ]);
          });
    } else {
      Navigator.pop(context);
    }
  }
}
