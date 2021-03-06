import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:yaml/yaml.dart';
import 'package:ibcore/interfaces/CustomAction.dart';
import 'package:ibcore/interfaces/ActiveAction.dart';
import 'package:ibcore/utils.dart';

class IBLabel extends Label {
  final String _text;
  final TextAlign _textAlign;
  final TextStyle _textStyle;
  final Size _size;
  final Offset _position;
  final double _scale;
  final double _rotation;

  IBLabel(this._text, this._textAlign, this._textStyle, this._size,
      this._position, this._scale, this._rotation)
      : super(_text, textAlign: _textAlign, textStyle: _textStyle) {
    scale = _scale;
    position = Offset(_position.dx + _size.width / 2, _position.dy);
    rotation = _rotation;
    userInteractionEnabled = true;
  }

  // Offset range;
  List<ActiveAction> onClickActions = new List<ActiveAction>();

  void addActiveAction(String event, YamlMap motion) {
    Type type;
    switch (event) {
      case 'onClick':
        type = PointerDownEvent;
        onClickActions.add(new ActiveAction(type, motion));
        break;
      default:
    }
  }

  @override
  bool isPointInside(Offset point) {
    Offset checkPoint = parent.convertPointFromNode(point, this);
    if (checkPoint.dx >= position.dx - _size.width / 2 &&
        checkPoint.dx <= _size.width + position.dx - _size.width / 2 &&
        checkPoint.dy <= _size.height + position.dy &&
        checkPoint.dy >= position.dy) return true;

    return false;
  }

  @override
  handleEvent(SpriteBoxEvent event) {
    if (event.type == PointerDownEvent) {
      // Offset currentPosition = parent.convertPointToNodeSpace(event.boxPosition);
      // this.range = Offset(currentPosition.dx - position.dx, currentPosition.dy - position.dy);
      for (var action in onClickActions) {
        List<CustomAction> motionDestruct = Utils.createActions(
            YamlList.wrap(List()..add(action.motion)), this, _size, parent);
        motions.run(motionDestruct[0].motion);
      }
    }
    // if (event.type == PointerMoveEvent) {
    //   Offset currentPosition = parent.convertPointToNodeSpace(event.boxPosition);
    //   Offset newPosition = Offset(currentPosition.dx - range.dx, currentPosition.dy - range.dy);
    //   // if (newPosition.dx < 0 || newPosition.dx > 1024.0 - _size.width || newPosition.dy < 0 || newPosition.dy > 768.0 - _size.height)
    //   //   return false;
    //   this.position = newPosition;
    // }
    return true;
  }
}
