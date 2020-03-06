import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'constants.dart' as Constants;

class IBTranslation {
  static Motion createMotion(
    String motionName,
    double duration,
    { Function(dynamic) setterFunction,
    Offset startVal,
    Offset endVal, 
    int numRepeat,
    List<Motion> motions}) {
      switch (motionName) {
        case Constants.MOTION_TWEEN:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
          );
        case Constants.MOTION_TWEEN_REPEAT:
          return new MotionRepeat(MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
          ), numRepeat);
          break;
        case Constants.MOTION_SEQUENCE:
          return new MotionSequence(motions);
          break;
        case Constants.MOTION_BOUNCED_OUT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.bounceOut,
          );
        break;
        case Constants.MOTION_BOUNCED_IN:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.bounceIn,
          );
        break;
        case Constants.MOTION_BOUNCED_IN_OUT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.bounceInOut,
          );
        break;
        case Constants.MOTION_DECELERATE:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.decelerate,
          );
        break;
        case Constants.MOTION_EASE:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.ease,
          );
        break;
        case Constants.MOTION_EASE_IN:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeIn,
          );
        break;
        case Constants.MOTION_EASE_IN_SINE:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInSine,
          );
        break;
        case Constants.MOTION_EASE_IN_QUAD:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInQuad,
          );
        break;
        case Constants.MOTION_EASE_IN_CUBIC:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInCubic,
          );
        break;
        case Constants.MOTION_EASE_IN_QUART:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInQuart,
          );
        break;
        case Constants.MOTION_EASE_IN_QUINT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInQuint,
          );
        break;
        case Constants.MOTION_EASE_IN_EXPO:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInExpo,
          );
        break;
        case Constants.MOTION_EASE_IN_CIRC:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInCirc,
          );
        break;
        case Constants.MOTION_EASE_IN_BACK:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInBack,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOut,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_SINE:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutSine,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_QUAD:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutQuad,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_CUBIC:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutCubic,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_QUART:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutQuart,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_QUINT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutQuint,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_EXPO:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutExpo,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_CIRC:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutCirc,
          );
        break;
        case Constants.MOTION_EASE_IN_OUT_BACK:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeInOutBack,
          );
        break;
        case Constants.MOTION_EASE_OUT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOut,
          );
        break;
        case Constants.MOTION_EASE_OUT_SINE:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutSine,
          );
        break;
        case Constants.MOTION_EASE_OUT_QUAD:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutQuad,
          );
        break;
        case Constants.MOTION_EASE_OUT_CUBIC:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutCubic,
          );
        break;
        case Constants.MOTION_EASE_OUT_QUART:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutQuart,
          );
        break;
        case Constants.MOTION_EASE_OUT_QUINT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutQuint,
          );
        break;
        case Constants.MOTION_EASE_OUT_EXPO:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutExpo,
          );
        break;
        case Constants.MOTION_EASE_OUT_CIRC:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutCirc,
          );
        break;
        case Constants.MOTION_EASE_OUT_BACK:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.easeOutBack,
          );
        break;
        case Constants.MOTION_ELASTIC_IN:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.elasticIn,
          );
        break;
        case Constants.MOTION_ELASTIC_IN_OUT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.elasticInOut,
          );
        break;
        case Constants.MOTION_ELASTIC_OUT:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.elasticOut,
          );
        break;
        case Constants.MOTION_FAST_OUT_SLOW_IN:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.fastOutSlowIn,
          );
        break;
        case Constants.MOTION_SLOW_MIDDLE:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.slowMiddle,
          );
        break;
        case Constants.MOTION_LINEAR:
          return new MotionTween<Offset> (
            setterFunction,
            startVal,
            endVal,
            duration,
            Curves.linear,
          );
        break;
        default:
          return null;
          break;
      }
  }
}