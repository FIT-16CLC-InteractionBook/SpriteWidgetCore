import 'package:flutter/material.dart';
import 'package:ibcore/KaraokeTextObject.dart';

class IBKaraokeText extends StatefulWidget {
  final Size size;
  final List<KaraokeText> listTexts;
  final String highlightColor;
  final TextStyle textStyle;
  final  Stream<Duration> soundStream;

  IBKaraokeText(this.size, this.listTexts, this.highlightColor, this.textStyle, this.soundStream);

  @override
  _IBKaraokeTextState createState() => _IBKaraokeTextState(size, listTexts, highlightColor, textStyle, soundStream);
}

class _IBKaraokeTextState extends State<IBKaraokeText> {
  final Size size;
  final List<KaraokeText> listTexts;
  final String highlightColor;
  final TextStyle textStyle;
  final Stream<Duration> soundStream;

  _IBKaraokeTextState(this.size, this.listTexts, this.highlightColor, this.textStyle, this.soundStream);

  @override
  void initState() {
    super.initState();
    soundStream.listen((event) {
      print(event);
    });
  }

  @override 
  Widget build(BuildContext buildContext) {
    print('Build Textspan');
    return RichText(
      text: TextSpan(
        style: textStyle,
        children: listTexts.map((text) {
          return TextSpan(
            text: text.content,
            style: TextStyle(color: Color(int.parse(highlightColor))),
          );
        }).toList()
      )
    );
  }
}