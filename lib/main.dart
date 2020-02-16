import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui';
import 'IBLabel.dart';
import 'IBTranslation.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => new MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  NodeBook rootNode;
  var size;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => yourFunction(context));
    rootNode = new NodeBook();
  }

  yourFunction(BuildContext context) {
    Offset a = rootNode.convertPointToNodeSpace(const Offset(300.0,400.0));
    IBLabel label = new IBLabel("Tessttt", TextAlign.center, new TextStyle(fontSize: 30), a, 1.0, 0.0, 1.0);

    MotionTween b = new MotionTween<Offset> (
      (a) => label.position = a,
      label.position,
      rootNode.convertPointToNodeSpace(const Offset(300.0,300.0)),
      2.0,
      Curves.bounceIn,
    );
    // Motion b = Utils.createMotion(
    //   "BouncedOut", 
    //   1.0,
    //   setterFunction: (a) => label.position = a,
    //   startVal: label.position,
    //   endVal: rootNode.convertPointToNodeSpace(const Offset(300.0,300.0)),
    //   numRepeat: 20);
    label.motions.run(b);
    rootNode.addChild(label);
  }

  @override
  Widget build(BuildContext context) {
    return new SpriteWidget(rootNode);
  }
}

class NodeBook extends NodeWithSize {
  NodeBook() : super(const Size(1024.0, 1024.0)) {

    // Start by adding a background.
    _background = new GradientNode(
      this.size,
      Color(0xff5ebbd5),
      Color(0xff0b2734),
    );
    addChild(_background);
  }

  GradientNode _background;
}
class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.colorTop, this.colorBottom) : super(size);

  Color colorTop;
  Color colorBottom;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    Rect rect = Offset.zero & size;
    Paint gradientPaint = new Paint()..shader = new LinearGradient(
      begin: FractionalOffset.topLeft,
      end: FractionalOffset.bottomLeft,
      colors: <Color>[colorTop, colorBottom],
      stops: <double>[0.0, 1.0]
    ).createShader(rect);

    canvas.drawRect(rect, gradientPaint);
  }
}