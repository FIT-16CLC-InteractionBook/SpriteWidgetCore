import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:sprite_widget/CustomAction.dart';
import 'package:sprite_widget/IBLabel.dart';
import 'package:sprite_widget/IBObject.dart';
import 'package:sprite_widget/IBPage.dart';
import 'package:sprite_widget/NodeBook.dart';
import 'package:flutter/painting.dart';
import 'package:spritewidget/spritewidget.dart';
import 'IBTranslation.dart';
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

  static Future<List<IBPage>> loadPage(YamlList doc) async {
    var completer = new Completer<List<IBPage>>();
    List<IBPage> pages = new List<IBPage>();
    for (var iPage in doc) {
      var page = iPage['page'];
      List<IBObject> objects = new List<IBObject>();
      for (var iObject in page['objects']) {
        var object = iObject['object'];
        switch (object['type']) {
          case Constants.TEXT:
            Map destructText = destructTextObject(object);
            objects.add(new IBObject('text', destructText));
            break;
          default:
        }
      }
      pages.add(new IBPage(page['index'], objects));
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
      'object-actions': object['object-actions'],
    });
  }

  static List<Node> createObjectsInPage(IBPage page, NodeBook rootNode){
    List<IBObject> objects = page.objects;
    List<Node> spriteObjects = new List<Node>();
    for (var iObject in objects) {
      Map object = iObject.object;
      switch (iObject.type) {
        case 'text':
          IBLabel label = new IBLabel(
            object['content'],
            ui.TextAlign.start, 
            object['properties']['text-style'],
            object['size'],
            object['coordinates'],
            object['properties']['scale'], 
            object['properties']['rotation'], 
            object['user-interaction']);
          List<CustomAction> actions = createActions(object['object-actions'], label, rootNode);
          for (var action in actions) {
            switch (action.event) {
              case 'auto':
                label.motions.run(action.motion);
                break;
              case 'onClick':
                label.addActiveAction('onClick', action.motion);
                break;
              default:
            }
          }
          spriteObjects.add(label);
        break;
        default:
      }
    }

    return spriteObjects;
  }

  static List<CustomAction> createActions(YamlList objectsAction, Node object, NodeBook rootNode) {
    List<CustomAction> spriteActions = new List<CustomAction>();
    for (var iObjAction in objectsAction) {
      var objAction = iObjAction['object-action'];
      switch (objAction['type']) {
        case Constants.SEQUENCE_ACTION:
          List<Motion> motions = new List<Motion>();
          YamlList actions = objAction['actions'];
          for (var iAction in actions) {
            var action = iAction['action'];
            Motion motion = createMotion(action, object, rootNode);
            motions.add(motion);
          }
          Motion sequenceMotion = IBTranslation.createMotion(Constants.MOTION_SEQUENCE, 1.0, motions: motions);
          spriteActions.add(new CustomAction(objAction['active']['type'], sequenceMotion));
          break;
        default:
      }
    }
    return spriteActions;
  }

  static Motion createMotion(YamlMap action, Node object, NodeBook rootNode) {
    switch (action['type']) {
      case 'move':
        var parameters = action['parameters'];
        return IBTranslation.createMotion(
          parameters['name'], 
          parameters['duration'] ?? 1.0,
          setterFunction: (newPos) => object.position = newPos,
          startVal: Offset(parameters['start-val']['x'], parameters['start-val']['y']),
          endVal: Offset(parameters['end-val']['x'], parameters['end-val']['y']),);
        break;
      default:
    }

    return null;
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