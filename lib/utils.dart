import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class Utils {
  static Motion createMotion(
    String motionName,
    double duration,
    { Function(dynamic) setterFunction,
    Offset startVal,
    Offset endVal, 
    Curve curve }) {
      switch (motionName) {
        case 'MotionTween':
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
          );
          case 'MotionTweenRepeat':
          
          break;
        default:
          return null;
          break;
      }
  }
}