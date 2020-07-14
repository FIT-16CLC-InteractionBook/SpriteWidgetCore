import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ibcore/main.dart';
import 'package:union/union.dart';

Union2<File, String> union = 'assets/book_structure_template.yml'.asSecond();
void main() => runApp(IBCore(union, Orientation.portrait));
