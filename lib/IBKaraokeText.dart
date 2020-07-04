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
  int counter = -1;

  _IBKaraokeTextState(this.size, this.listTexts, this.highlightColor, this.textStyle, this.soundStream);

  @override
  void initState() {
    super.initState();
    soundStream.listen((event) {
      var serializedEvent = event.toString();
      var aftercut = serializedEvent.split('.')[0];
      if (counter < listTexts.length) {
        if (counter == -1) {
          counter = counter + 1;
          return;
        }
        if (aftercut == listTexts[counter].start && !listTexts[counter].isPlayed) {
          listTexts[counter].isPlayed = true;
          setState(() {});
          return;
        }
        if (aftercut == listTexts[counter].end && listTexts[counter].isPlayed) {
          listTexts[counter].isPlayed = false;
          setState(() {
            counter = counter + 1;
          });
        }
      }
    });
  }

  @override 
  Widget build(BuildContext buildContext) {
    return RichText(
      text: TextSpan(
        style: textStyle,
        children: listTexts.map((text) {
          return TextSpan(
            text: text.content,
            style: text.isPlayed ? TextStyle(color: Colors.red) : null,
          );
        }).toList()
      )
    );
  }
}