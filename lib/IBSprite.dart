import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sprite_widget/CustomAction.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:yaml/yaml.dart';
import 'ActiveAction.dart';
import 'utils.dart';

class IBSprite extends Sprite {

  final ui.Image _image;
  final Size _size;
  final Offset _position;
  final double _scale;
  final double _rotation;
  final double _opacity; 
  final bool _userInteractionEnabled; 

  IBSprite(this._image, this._size, this._position, this._scale, this._rotation, this._opacity, this._userInteractionEnabled) : super.fromImage(_image) {
    size = _size;
    position = _position;
    scale= _scale;
    rotation = _rotation;
    opacity = _opacity;
    userInteractionEnabled = _userInteractionEnabled;
    pivot = Offset(0.0, 0.0);
  }

  Offset range;
  List<ActiveAction> onClickActions = new List<ActiveAction>();

  void addActiveAction(String event, YamlMap motion) {
    Type type;
    switch (event) {
      case 'on-click':
        type = PointerDownEvent;
        onClickActions.add(new ActiveAction(type, motion));
        break;
      default:
    }
  }
  @override
  bool isPointInside(Offset point) {
    Offset checkPoint = parent.convertPointFromNode(point, this);
    if (checkPoint.dx >= position.dx && checkPoint.dx <= size.width + position.dx && checkPoint.dy <= size.height + position.dy && checkPoint.dy >= position.dy)
      return true;

    return false;
  }

  @override handleEvent(SpriteBoxEvent event) {
    if (event.type == PointerDownEvent) {
      Offset currentPosition = parent.convertPointToNodeSpace(event.boxPosition);
      this.range = Offset(currentPosition.dx - position.dx, currentPosition.dy - position.dy);
      for (var action in onClickActions) {
        List<CustomAction> motionDestruct = Utils.createActions(YamlList.wrap(List()..add(action.motion)), this, parent);
        motions.run(motionDestruct[0].motion);
      }
    }
    if (event.type == PointerMoveEvent) {
      Offset currentPosition = parent.convertPointToNodeSpace(event.boxPosition);
      Offset newPosition = Offset(currentPosition.dx - range.dx, currentPosition.dy - range.dy);
      if (newPosition.dx < 0 || newPosition.dx > 1024.0 - _size.width || newPosition.dy < 0 || newPosition.dy > 768.0 - _size.height)
        return false;
      this.position = newPosition;
    }
    return true;
  }
}