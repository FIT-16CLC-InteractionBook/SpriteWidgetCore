import 'package:flutter/material.dart';
import 'package:ibcore/interfaces/IBObject.dart';
import 'package:spritewidget/spritewidget.dart';

class PageObject {
  String type;
  Node node;
  Widget widget;
  IBObject rawObject;

  PageObject(this.type, {this.node, this.widget, this.rawObject});
}