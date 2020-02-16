import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class IBLabel extends Label {
  final String txt;
  final TextAlign txtAlign;
  final TextStyle txtStyle;
  final Offset p;
  final double s;
  final double r;
  final double a; 
  // final MotionInterval m; //motions

  IBLabel(
    this.txt, 
    this.txtAlign, 
    this.txtStyle, 
    this.p, 
    this.s, 
    this.r, 
    this.a) : super(txt, textAlign: txtAlign, textStyle: txtStyle) {
    this.position = Offset(this.p.dx, this.p.dy);
    this.scale = this.s;
    this.rotation = this.r;
  }
}