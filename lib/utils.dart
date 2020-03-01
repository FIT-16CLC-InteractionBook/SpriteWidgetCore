import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
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

   static Map loadPage(YamlMap doc) {
    var backgroundProperty = doc['background'];
    var appPage = doc['app-page'];

    return new Map()..addAll({'background': backgroundProperty, 'app-page': appPage});
  }
}