import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class IBLabel extends Label {
  final String _text;
  final TextAlign _textAlign;
  final TextStyle _textStyle;
  final Offset _position;
  final double _scale;
  final double _rotation;
  final double _alpha; 

  IBLabel(
    this._text, 
    this._textAlign, 
    this._textStyle, 
    this._position, 
    this._scale, 
    this._rotation, 
    this._alpha) : super(_text, textAlign: _textAlign, textStyle: _textStyle) {
    this.position = Offset(this._position.dx, this._position.dy);
    this.scale = this._scale;
    this.rotation = this._rotation;
  }
}