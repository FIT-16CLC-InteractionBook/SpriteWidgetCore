// import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:ibcore/PageObject.dart';
import 'package:ibcore/IBPage.dart';
import 'package:ibcore/NodeBook.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:yaml/yaml.dart';
import 'package:union/union.dart';
import 'utils.dart';
import 'package:carousel_slider/carousel_slider.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIOverlays([]);
//   runApp(VideoPlayerApp());
// }

class IBCore extends StatefulWidget {
  final Union2<File, String> fileUrl;
  final Orientation orientation;
  IBCore(this.fileUrl, this.orientation): super();
  @override
  AppState createState() => new AppState(fileUrl, orientation);
}

class AppState extends State<IBCore> {
  var doc;
  bool isLoading = true;
  List<IBPage> pages;
  Map background;
  final Union2<File, String> fileUrl;
  final Orientation orientation;
  AppState(this.fileUrl, this.orientation) : super();

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) => loadBook(context));
    WidgetsBinding.instance.addPostFrameCallback((_) => initialData());
  }

  Future<String> loadDocString(Union2<File,String> union) async {
    var completer = new Completer<String>();
    
    this.fileUrl.switchCase((File value) async { 
      String fileText = await value.readAsString();
      return completer.complete(fileText);
    }, (String value) async { 
      String fileText = await rootBundle.loadString(value);
      return completer.complete(fileText);
    });

    return completer.future;
  }

  initialData() async {
    String fileText = await this.loadDocString(this.fileUrl);
    print(fileText);
    doc = loadYaml(fileText);
    Map main = Utils.loadMainData(doc['app']);

    background = await Utils.loadBackground(main['background']);
    pages = await Utils.loadPage(main['app-page']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MaterialApp(
            title: 'Title',
            home: new Container(child: Text('123')),
          )
        : MaterialApp(
            title: 'Title',
            home: MyWidget(background, pages),
          );
  }
}

class MyWidget extends StatefulWidget {
  final Map background;
  final List<IBPage> pages;
  MyWidget(this.background, this.pages);
  @override
  MyWidgetState createState() => new MyWidgetState(background, pages);
}

class MyWidgetState extends State<MyWidget> {
  final Map background;

  final List<IBPage> pages;
  static int totalPages;
  static List<NodeBook> rootNodes;

  bool loading = true;
  List<List<Widget>> specificObjects;

  List<List<PageObject>> renderPages;
  List<int> pageRendered;
  var size;
  // SpriteSheet _sprites;
  // ImageMap _images;
  // List<ParticleSystem> _particles = <ParticleSystem>[];
  MyWidgetState(this.background, this.pages) : super() {
    totalPages = pages.length;
  }

  @override
  void initState() {
    super.initState();
    rootNodes =
        List<NodeBook>.generate(totalPages, (i) => new NodeBook(background));
    specificObjects =
        List<List<Widget>>.generate(totalPages, (i) => new List<Widget>());
    renderPages = new List<List<PageObject>>();
    pageRendered = new List<int>();
    // SchedulerBinding.instance.addPostFrameCallback((_) => loadBook(context));
    WidgetsBinding.instance.addPostFrameCallback((_) => loadBook(context));
  }

  loadBook(BuildContext context) {
    for (var page in pages) {
      List<PageObject> pageObject =
          Utils.createObjectsInPage(page, rootNodes[0]);
      renderPages.add(pageObject);
    }
    for (var spriteObject in renderPages[0]) {
      if (spriteObject.type == 'node')
        rootNodes[0].addChild(spriteObject.node);
      else
        specificObjects[0].add(spriteObject.widget);
    }
    pageRendered.add(0);
    setState(() {
      loading = false;
    });
    // Offset a = rootNode.convertPointToNodeSpace(const Offset(0.0,0.0));
    // IBLabel label = new IBLabel(
    //   "123456",
    //   TextAlign.start,
    //   new TextStyle(fontSize: 30, color: Colors.black),
    //   new Size(100.0, 30.0),
    //   a,
    //   1.0,
    //   0.0,
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

  addObjectToPage(index) {
    var pageObjects = renderPages[index];
    for (var spriteObject in pageObjects) {
      if (spriteObject.type == 'node')
        rootNodes[index].addChild(spriteObject.node);
      else
        specificObjects[index].add(spriteObject.widget);
    }
    pageRendered.add(index);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Rerendering...');

    return loading
        ? Stack(
            children: List<Widget>.generate(
                totalPages,
                (i) {
                  print('Alo');
                  return new Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Stack(
                            children: <Widget>[
                              new SpriteWidget(rootNodes[i]),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                              ...specificObjects[i]
                                  .map((item) => item)
                                  .toList(),
                            ],
                          )),
                    );}),
          )
        : CarouselSlider(
            aspectRatio: 4 / 3,
            items: List.generate(
                totalPages,
                (i) { 
                  print('Running...');
                  return new Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Stack(
                            children: <Widget>[
                              new SpriteWidget(rootNodes[i]),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                              ...specificObjects[i]
                                  .map((item) => item)
                                  .toList(),
                            ],
                          )),
                    );}),
            viewportFraction: 1.0,
            // scrollPhysics: NeverScrollableScrollPhysics(),
            enableInfiniteScroll: false,
            onPageChanged: (index) {
              if (!pageRendered.contains(index)) addObjectToPage(index);
            },
          );
  }
}

// new Align(
//             alignment: Alignment.center,
//             child: AspectRatio(
//               aspectRatio: 4/3,
//               child:SizedBox(
//                 child: Stack(children: <Widget>[
//                 new SpriteWidget(rootNode),
//                 ...specificObject.map((item) => item).toList(),
//               ],),
//               ),),
//             );

// CarouselSlider(
//             items: List.generate(
//                 totalPages,
//                 (i) => new Align(
//                       alignment: Alignment.center,
//                       child: AspectRatio(
//                           aspectRatio: 4 / 3,
//                           child: Stack(
//                             children: <Widget>[
//                               ...specificObjects[i]
//                                   .map((item) => item)
//                                   .toList(),
//                               new SpriteWidget(rootNodes[i]),
//                             ],
//                           )),
//                     )),
//             viewportFraction: 1.0,
//             onPageChanged: (index) {
//               if (!pageRendered.contains(index))
//                 addObjectToPage(index);
//             },
//           );
