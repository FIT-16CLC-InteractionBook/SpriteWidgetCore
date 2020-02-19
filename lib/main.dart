import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/painting.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui;
import 'IBLabel.dart';
import 'IBTranslation.dart';
import 'IBSprite.dart';
import 'IBParticle.dart';
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
  SpriteSheet _sprites;
  ImageMap _images;
  List<ParticleSystem> _particles = <ParticleSystem>[];


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
    // Offset a = rootNode.convertPointToNodeSpace(const Offset(0.0,0.0));
    // ui.Image image = await getImage("https://picsum.photos/250?image=9");
    // IBSprite sprite = new IBSprite(image, new Size(200.0, 200.0), a, 1, 0, 1, true);
    _images = new ImageMap(rootBundle);
     _images.load([
      'assets/particle-0.png',
      'assets/particle-1.png',
      'assets/particle-2.png',
      'assets/particle-3.png',
      'assets/particle-4.png',
      'assets/particle-5.png',
    ]).then((List<ui.Image> images) {
      ParticleWorld _particleWorld = new ParticleWorld( _images, rootNode.convertPointToNodeSpace(const Offset(300.0,300.0)), const Size(100.0, 100.0));
      ParticlePreset.updateParticles(_particleWorld, ParticlePresetType.Fireworks);
      rootNode.addChild(_particleWorld);
     });
    // await _loadAssets(bundle);
    // _addParticles(1.0);
    // _addParticles(1.5);
    // _addParticles(2.0);
    // AudioPlayer audioPlayer = AudioPlayer();
    // int result = await audioPlayer.play("http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3");
  }

  // Future<Null> _loadAssets(AssetBundle bundle) async {
  //   _images = new ImageMap(bundle);
  //   // Load images using an ImageMap
  //   _images = new ImageMap(bundle);
  //   await _images.load(<String>[
  //     'assets/weathersprites.png',
  //   ]);

  //   // Load the sprite sheet, which contains snowflakes and rain drops.
  //   String json = await DefaultAssetBundle.of(context).loadString('assets/test.json');
  //   _sprites = new SpriteSheet(_images['assets/weathersprites.png'], json);
  // }

  void _addParticles(double distance) {
    ParticleSystem particles = new ParticleSystem(
      _sprites['raindrop.png'],
      transferMode: BlendMode.srcATop,
      posVar: rootNode.convertPointToNodeSpace(Offset(400.0, 400.0)),
      direction: 90.0,
      directionVar: 0.0,
      speed: 1000.0 / distance,
      speedVar: 100.0 / distance,
      startSize: 1.2 / distance,
      startSizeVar: 0.2 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 1.5 * distance,
      lifeVar: 1.0 * distance
    );
    particles.position = rootNode.convertPointToNodeSpace(const Offset(100.0, 100.0));
    particles.rotation = 10.0;
    particles.opacity = 0.0;

    _particles.add(particles);
    rootNode.addChild(particles);
  }

  // Completer<ImageInfo> completer = Completer();
  // Future<ui.Image> getImage(String path) async {
  //   var img = new NetworkImage(path);
  //   img.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info,bool _){
  //     completer.complete(info);
  //   }));
  //   ImageInfo imageInfo = await completer.future;
  //   return imageInfo.image;
  // }

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

// import 'dart:ui' as ui show Image;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:spritewidget/spritewidget.dart';

// import 'particle_designer.dart';

// void main() {
//   runApp(new MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Particle Designer'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   ImageMap _images;
//   bool _loaded = false;

//   @override
//   void initState() {
//     super.initState();

//     _images = new ImageMap(rootBundle);
//     _images.load([
//       'assets/particle-0.png',
//       'assets/particle-1.png',
//       'assets/particle-2.png',
//       'assets/particle-3.png',
//       'assets/particle-4.png',
//       'assets/particle-5.png',
//     ]).then((List<ui.Image> images) {
//       setState(() => _loaded = true);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: _loaded ? new ParticleDesigner(images: _images,) : null,
//     );
//   }
// }
