import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:sprite_widget/IBLabel.dart';
import 'package:sprite_widget/NodeBook.dart';
import 'package:flutter/painting.dart';

import 'constants.dart' as Constants;
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class Utils {
  static Map<String, YamlNode> loadMainData(YamlMap doc) {
    YamlMap backgroundProperty = doc['background'];
    YamlList appPage = doc['app-page'];

    return new Map<String,YamlNode>()..addAll({'background': backgroundProperty, 'app-page': appPage});
  }

   static Future<Map<String, dynamic>> loadBackground(YamlMap doc) async {
    var completer = new Completer<Map<String,dynamic>>();

    String imageLink = doc['image'];
    int color = doc['color'];
    if (imageLink != '') {
      ByteData data = await rootBundle.load(imageLink);
      ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
        return completer.complete(new Map<String,dynamic>()..addAll({'image': img, 'color': color}));
      });

      Map<String, dynamic> result = await completer.future;
      return result;
    }

    return new Map<String,dynamic>()..addAll({'image': '', 'color': color});
  }

  static Future<Map<String, dynamic>> loadPage(YamlList doc) async {
    var completer = new Completer<Map<String,dynamic>>();
    Map<String, dynamic> pages = new Map<String,dynamic>();
    for (var iPage in doc) {
      var page = iPage['page'];
      Map<String, dynamic> objects = new Map<String,dynamic>();
      for (var iObject in page['objects']) {
        var object = iObject['object'];
        switch (object['type']) {
          case Constants.TEXT:
            Map destructText = destructTextObject(object);
            objects.addAll({'text-${object['index']}': destructText});
            break;
          default:
        }
      }
      pages.addAll({'page-${page['index']}': objects});
    }
    completer.complete(pages);
    return completer.future;
  }

  static Map<String, dynamic> destructTextObject(YamlMap object){
    ui.Offset coordinates = new ui.Offset(object['coordinates']['x'], object['coordinates']['y']);
    ui.Size size = new ui.Size(object['coordinates']['w'], object['coordinates']['h']);
    String content = object['content'];
    bool userInteraction = object['properties']['user-interaction'] ?? false;
    TextStyle textStyle = new TextStyle(
      fontFamily: object['properties']['font'],
      fontWeight: getFontWeight(object['properties']['font-weight']),
      fontSize: object['properties']['fontSize'] ?? 14, 
      color: ui.Color(object['properties']['color'] ?? 0x00000000).withOpacity(object['properties']['opacity'] ?? 1.0),

    );
    Map<String, dynamic> properties = new Map<String,dynamic>()..addAll({
      'rotation': object['properties']['rotation'] ?? 0.0,
      'text-style': textStyle,
      'scale': object['properties']['scale'] ?? 1.0,
    });

    return new Map<String, dynamic>()..addAll({
      'coordinates': coordinates,
      'size': size,
      'content': content,
      'user-interaction': userInteraction,
      'properties': properties,
    });
  }

  static Map<String, dynamic> createObjectsInPage(Map<String, dynamic> objects, NodeBook rootNode){
    Map<String, dynamic> spriteObjects = new Map<String, dynamic>();
    for (var key in objects.keys) {
      var type = checkRegex(key);
      var object = objects[key];
      switch (type) {
        case 'text':
          IBLabel label = new IBLabel(
            object['content'],
            ui.TextAlign.start, 
            object['properties']['text-style'],
            object['size'],
            rootNode.convertPointToNodeSpace(object['coordinates']),
            object['properties']['scale'], 
            object['properties']['rotation'], 
            object['user-interaction']);
          spriteObjects.addAll({'$key': label});
        break;
        default:
      }
    }

    return spriteObjects;
  }

  static String checkRegex(String testString) {
    RegExp regExpText = new RegExp(r"^text");
    if (regExpText.hasMatch(testString)) {
      return 'text';
    }
  }

  static FontWeight getFontWeight(int weight) {
    switch (weight) {
      case 400:
        return FontWeight.w400;
        break;
      default:
        return FontWeight.w400;
    }
  }
}