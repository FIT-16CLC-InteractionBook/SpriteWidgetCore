// import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:ibcore/interfaces/PageObject.dart';
import 'package:ibcore/interfaces/IBPage.dart';
import 'package:ibcore/core/NodeBook.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:yaml/yaml.dart';
import 'package:union/union.dart';
import 'package:ibcore/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:PDFViewer/PDFViewer.dart';
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
            home:
              MyWidget(background, pages, orientation),    
        );
  }
}

class MyWidget extends StatefulWidget {
  final Map background;
  final List<IBPage> pages;
  final Orientation orientation;
  
  MyWidget(this.background, this.pages, this.orientation);
  @override
  MyWidgetState createState() => new MyWidgetState(background, pages, orientation);
}

class MyWidgetState extends State<MyWidget> with WidgetsBindingObserver {
  final Map background;
  final List<IBPage> pages;
  final Orientation orientation;

  static int totalPages;
  static List<NodeBook> rootNodes;

  bool first = true;
  bool loading = true;

  PDFViewer pdfViewer = new PDFViewer();
  List<List<PageObject>> renderPages;
  List<List<Widget>> specificObjects;
  List<int> pageRendered;
  Orientation currentOrientation;
  
  MyWidgetState(this.background, this.pages, this.orientation) : super() {
    totalPages = pages.length;
    currentOrientation = orientation;
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
    WidgetsBinding.instance.addPostFrameCallback((_) => loadBook(context));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeMetrics() {
  //   // if (currentOrientation != orientation) {
  //   //   print('123');
  //   // }

  //   if (!loading && !first) {
  //       var timer = Timer(Duration(seconds: 2), () {
  //         List<List<PageObject>> newRenderPages = new List<List<PageObject>>();
  //         List<List<Widget>> newSpecificObjects = List<List<Widget>>.generate(totalPages, (i) => new List<Widget>());
  //         renderPages.asMap().forEach((index, page) {
  //           List<PageObject> pageObjects = new List<PageObject>();
  //           page.forEach((spriteObject) {
  //             if (spriteObject.type == 'widget') {
  //               PageObject newSpriteObject = Utils.reCalculateSpecificObjects(spriteObject.rawObject, rootNodes[0]);
  //               pageObjects.add(newSpriteObject);
  //               if (specificObjects[index].length != 0) {
  //                 newSpecificObjects[index].add(newSpriteObject.widget);
  //               }
  //             } else {
  //               pageObjects.add(spriteObject);
  //             }
  //           });
  //           newRenderPages.add(pageObjects);
  //         });

  //         setState(() {
  //           renderPages = newRenderPages;
  //           specificObjects = newSpecificObjects;
  //         });
  //       });
  //   } else {
  //     first = false;
  //   }
  // }

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
  }

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
    return loading
        ? Stack(
            children: List<Widget>.generate(
                totalPages,
                (i) {
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
                  return new Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Stack(
                            children: <Widget>[
                              pdfViewer,
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
              pdfViewer.pdfViewController.changePage(index);
              if (!pageRendered.contains(index)) addObjectToPage(index);
            },
          );
  }
}
