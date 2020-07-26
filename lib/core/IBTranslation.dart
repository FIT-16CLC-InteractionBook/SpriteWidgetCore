import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:ibcore/constants/constants.dart' as Constants;

class IBTranslation {
  static Motion createMotion(String motionName, String type, double duration,
      {Function(dynamic) setterFunction,
      Offset startVal,
      Offset endVal,
      double propStartVal,
      double propEndVal,
      int numRepeat,
      Motion motion,
      Curve curve,
      List<Motion> motions}) {
    Curve curve = Curves.ease;
    switch (motionName) {
      case Constants.MOTION_BOUNCED_OUT:
        curve = Curves.bounceOut;
        break;
      case Constants.MOTION_BOUNCED_IN:
        curve = Curves.bounceIn;
        break;
      case Constants.MOTION_BOUNCED_IN_OUT:
        curve = Curves.bounceInOut;
        break;
      case Constants.MOTION_DECELERATE:
        curve = Curves.decelerate;
        break;
      case Constants.MOTION_EASE:
        curve = Curves.ease;
        break;
      case Constants.MOTION_EASE_IN:
        curve = Curves.easeIn;
        break;
      case Constants.MOTION_EASE_IN_SINE:
        curve = Curves.easeInSine;
        break;
      case Constants.MOTION_EASE_IN_QUAD:
        curve = Curves.easeInQuad;
        break;
      case Constants.MOTION_EASE_IN_CUBIC:
        curve = Curves.easeInCubic;

        break;
      case Constants.MOTION_EASE_IN_QUART:
        curve = Curves.easeInQuart;

        break;
      case Constants.MOTION_EASE_IN_QUINT:
        curve = Curves.easeInQuint;

        break;
      case Constants.MOTION_EASE_IN_EXPO:
        curve = Curves.easeInExpo;

        break;
      case Constants.MOTION_EASE_IN_CIRC:
        curve = Curves.easeInCirc;

        break;
      case Constants.MOTION_EASE_IN_BACK:
        curve = Curves.easeInBack;

        break;
      case Constants.MOTION_EASE_IN_OUT:
        curve = Curves.easeInOut;

        break;
      case Constants.MOTION_EASE_IN_OUT_SINE:
        curve = Curves.easeInOutSine;

        break;
      case Constants.MOTION_EASE_IN_OUT_QUAD:
        curve = Curves.easeInOutQuad;

        break;
      case Constants.MOTION_EASE_IN_OUT_CUBIC:
        curve = Curves.easeInOutCubic;

        break;
      case Constants.MOTION_EASE_IN_OUT_QUART:
        curve = Curves.easeInOutQuart;

        break;
      case Constants.MOTION_EASE_IN_OUT_QUINT:
        curve = Curves.easeInOutQuint;

        break;
      case Constants.MOTION_EASE_IN_OUT_EXPO:
        curve = Curves.easeInOutExpo;

        break;
      case Constants.MOTION_EASE_IN_OUT_CIRC:
        curve = Curves.easeInOutCirc;

        break;
      case Constants.MOTION_EASE_IN_OUT_BACK:
        curve = Curves.easeInOutBack;

        break;
      case Constants.MOTION_EASE_OUT:
        curve = Curves.easeOut;

        break;
      case Constants.MOTION_EASE_OUT_SINE:
        curve = Curves.easeOutSine;

        break;
      case Constants.MOTION_EASE_OUT_QUAD:
        curve = Curves.easeOutQuad;

        break;
      case Constants.MOTION_EASE_OUT_CUBIC:
        curve = Curves.easeOutCubic;

        break;
      case Constants.MOTION_EASE_OUT_QUART:
        curve = Curves.easeOutQuart;

        break;
      case Constants.MOTION_EASE_OUT_QUINT:
        curve = Curves.easeOutQuint;

        break;
      case Constants.MOTION_EASE_OUT_EXPO:
        curve = Curves.easeOutExpo;

        break;
      case Constants.MOTION_EASE_OUT_CIRC:
        curve = Curves.easeOutCirc;

        break;
      case Constants.MOTION_EASE_OUT_BACK:
        curve = Curves.easeOutBack;

        break;
      case Constants.MOTION_ELASTIC_IN:
        curve = Curves.elasticIn;

        break;
      case Constants.MOTION_ELASTIC_IN_OUT:
        curve = Curves.elasticInOut;

        break;
      case Constants.MOTION_ELASTIC_OUT:
        curve = Curves.elasticOut;

        break;
      case Constants.MOTION_FAST_OUT_SLOW_IN:
        curve = Curves.fastOutSlowIn;

        break;
      case Constants.MOTION_SLOW_MIDDLE:
        curve = Curves.slowMiddle;

        break;
      case Constants.MOTION_LINEAR:
        curve = Curves.linear;

        break;
      case Constants.MOTION_FAST_LINEAR_TO_SLOW_EASE_IN:
        curve = Curves.fastLinearToSlowEaseIn;

        break;
      case Constants.MOTION_LINEAR_TO_EASE_OUT:
        curve = Curves.linearToEaseOut;

        break;
      case Constants.MOTION_EASE_IN_TO_LINEAR:
        curve = Curves.easeInToLinear;

        break;
    }

    switch (type) {
      case Constants.MOTION_TWEEN:
        return new MotionTween<Offset>(
          setterFunction,
          startVal,
          endVal,
          duration,
          curve,
        );
      case Constants.MOTION_TWEEN_ROTATE:
      case Constants.MOTION_TWEEN_OPACITY:
      case Constants.MOTION_TWEEN_SCALE:
      case Constants.MOTION_TWEEN_SKEW:
        return new MotionTween<double>(
          setterFunction,
          propStartVal,
          propEndVal,
          duration,
          curve,
        );
      case Constants.MOTION_TWEEN_REPEAT:
        return new MotionRepeat(motion, numRepeat);
        break;
      case Constants.MOTION_SEQUENCE:
        return new MotionSequence(motions);
        break;
      case Constants.MOTION_REPEAT_FOREVER:
        return new MotionRepeatForever(motion);
        break;
      default:
        return null;
        break;
    }
  }
}
