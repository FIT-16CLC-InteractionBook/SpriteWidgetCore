import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/painting.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui;
import 'IBLabel.dart';
import 'IBTranslation.dart';
import 'IBSprite.dart';
import 'package:flutter/scheduler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(App());
}

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

  yourFunction(BuildContext context) async {
    // Offset a = rootNode.convertPointToNodeSpace(const Offset(100.0,100.0));
    // IBLabel label = new IBLabel(
    //   "123456",
    //   TextAlign.start, 
    //   new TextStyle(fontSize: 30),
    //   new Size(100.0, 100.0),
    //   a, 
    //   1.0, 
    //   0.0, 
    //   1.0,
    //   true);
    // Motion b = Utils.createMotion(
    //   "BouncedOut", 
    //   1.0,
    //   setterFunction: (a) => label.position = a,
    //   startVal: label.position,
    //   endVal: rootNode.convertPointToNodeSpace(const Offset(300.0,300.0)),
    //   numRepeat: 20);
    // ui.Image image =
    Offset a = rootNode.convertPointToNodeSpace(const Offset(0.0,0.0));
    ui.Image image = await getImage("https://picsum.photos/250?image=9");
    IBSprite sprite = new IBSprite(image, new Size(200.0, 200.0), a, 1, 0, 1, true);
    rootNode.addChild(sprite);
  }
  Completer<ImageInfo> completer = Completer();
  Future<ui.Image> getImage(String path) async {
    var img = new NetworkImage(path);
    img.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info,bool _){
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
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