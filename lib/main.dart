// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/painting.dart';
import 'package:sprite_widget/IBLabel.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:yaml/yaml.dart';
import 'utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(App());
}

class App extends StatefulWidget {
   @override
   AppState createState() => new AppState();
}

class AppState extends State<App> {
  var doc;
  bool isLoading = true;
  Map background;
  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) => loadBook(context));
    WidgetsBinding.instance.addPostFrameCallback((_) => initialData());
  }

  initialData() async {
    String fileText = await rootBundle.loadString('assets/book_structure_template.yml');
    doc = loadYaml(fileText);
    Map main = Utils.loadMainData(doc['app']);

    background = await Utils.loadBackground(main['background']);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? MaterialApp(
      title: 'Title',
      home: new Container(child: Text('123')),
    ) : MaterialApp(
      title: 'Title',
      home: MyWidget(background),
    );
  }
}

class MyWidget extends StatefulWidget {
  final Map background;
  MyWidget(this.background);
  @override
  MyWidgetState createState() => new MyWidgetState(background);
}

class MyWidgetState extends State<MyWidget> {

  final Map background;
  NodeBook rootNode;
  var size;
  // SpriteSheet _sprites;
  // ImageMap _images;
  // List<ParticleSystem> _particles = <ParticleSystem>[];
  MyWidgetState(this.background) : super();

  @override
  void initState() {
    super.initState();
    rootNode = new NodeBook(background);
    // SchedulerBinding.instance.addPostFrameCallback((_) => loadBook(context));
    WidgetsBinding.instance.addPostFrameCallback((_) => loadBook(context));
  }

  loadBook(BuildContext context) {
    Offset a = rootNode.convertPointToNodeSpace(const Offset(0.0,0.0));
    IBLabel label = new IBLabel(
      "123456",
      TextAlign.start, 
      new TextStyle(fontSize: 30, color: Colors.black),
      new Size(100.0, 30.0),
      a, 
      1.0, 
      0.0, 
      true);
    rootNode.addChild(label);
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
    // _images = new ImageMap(rootBundle);
    //  _images.load([
    //   'assets/particle-0.png',
    //   'assets/particle-1.png',
    //   'assets/particle-2.png',
    //   'assets/particle-3.png',
    //   'assets/particle-4.png',
    //   'assets/particle-5.png',
    // ]).then((List<ui.Image> images) {
      // ParticleWorld _particleWorld = new ParticleWorld( _images, rootNode.convertPointToNodeSpace(const Offset(300.0,300.0)), const Size(100.0, 100.0));
      // ParticlePreset.updateParticles(_particleWorld, ParticlePresetType.Fire);
      // rootNode.addChild(_particleWorld);
    //  });
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
    return new Align(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 4/3,
          child: new SpriteWidget(rootNode),),
        ) ;
  }
}

class NodeBook extends NodeWithSize {

  final Map background;
  NodeBook(this.background) : super(const Size(1024.0, 768.0)) {
    
    // Start by adding a background.
    _background = new GradientNode(
      this.size,
      background,
    );
    addChild(_background);
  }

  GradientNode _background;
}
class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.background) : super(size);

  final Map background;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);
    var img = background['image'];
    var color = background['color'];
    if (img != '') {
      paintImage(canvas: canvas, rect: Offset.zero & size, image: img, fit: BoxFit.fill);
    } else {
      Rect rect = Offset.zero & size;
      Paint gradientPaint = new Paint()..shader = new LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[Color(color), Color(color)],
        stops: <double>[0.0, 1.0]
      ).createShader(rect);

      canvas.drawRect(rect, gradientPaint);
    }
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


// import 'package:flutter/material.dart';
// import 'IBGallery.dart';

// void main() => runApp(new CarouselDemo());

// class CarouselDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text('Carousel slider demo')),
//         body: Container(
//           height: 300.0,
//           width: 300.0,
//           child: CarouselWithIndicator(Size(300.0, 300.0))) 
//       ),
//     );
//   }
// }