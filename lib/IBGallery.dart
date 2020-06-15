import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class IBGallery extends StatefulWidget {
  final Size size;
  final List<Uint8List> imgList;
  IBGallery(this.size, this.imgList) : super();
  @override
  _IBGalleryState createState() =>
      _IBGalleryState(size, imgList);
}

class _IBGalleryState extends State<IBGallery> {
  static Size size;
  static List<Uint8List> imgList;

  _IBGalleryState(_size, _imgList) : super() {
    size = _size;
    imgList = _imgList;
  }

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    List child = map<Widget>(
      imgList,
      (index, i) {
        return Container(
          child: ClipRRect(
            child: Stack(children: <Widget>[
              Image.memory(i,
              fit: BoxFit.cover, width: size.width, height: size.height,),
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
            ]),
          ),
        );
      },
    ).toList();

    return Column(children: [
      CarouselSlider(
        height: size.height - 8,
        items: child,
        viewportFraction: 1.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
          (index, url) {
            return Container(
              width: 5.0,
              height: 5.0,
              margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 1.5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}

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
//           child: IBGallery())
//       ),
//     );
//   }
// }
