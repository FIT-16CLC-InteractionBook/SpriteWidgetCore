import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class PageObject {
  String type;
  Node node;
  Widget widget;

  PageObject(this.type, {this.node, this.widget});
}