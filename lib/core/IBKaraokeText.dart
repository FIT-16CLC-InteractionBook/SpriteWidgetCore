import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ibcore/interfaces/KaraokeTextObject.dart';

class IBKaraokeText extends StatefulWidget {
  final List<KaraokeText> listTexts;
  final String highlightColor;
  final TextStyle textStyle;
  final  Stream<Duration> soundStream;

  IBKaraokeText(this.listTexts, this.highlightColor, this.textStyle, this.soundStream);

  @override
  _IBKaraokeTextState createState() => _IBKaraokeTextState(listTexts, highlightColor, textStyle, soundStream);
}

class _IBKaraokeTextState extends State<IBKaraokeText> {
  final List<KaraokeText> listTexts;
  final String highlightColor;
  final TextStyle textStyle;
  final Stream<Duration> soundStream;
  int counter = -1;
  bool isReload = false;
  Color hexColor;
  StreamSubscription<Duration> subscription;

  _IBKaraokeTextState(this.listTexts, this.highlightColor, this.textStyle, this.soundStream);


  @override
  void initState() {
    super.initState();
    String subStringColor = highlightColor.substring(1);
    int convertedColor = int.parse('0xff' + subStringColor);
    hexColor = Color(convertedColor);
    subscription = soundStream.listen((event) {
      if (counter == listTexts.length) {
        counter = 0;
        isReload = true;
      }
      var serializedEvent = event.toString();
      var aftercut = serializedEvent.split('.')[0];
      if (counter < listTexts.length) {
        if (counter == -1) {
          counter = counter + 1;
          return;
        }
        if (aftercut == listTexts[counter].start && !listTexts[counter].isPlayed) {
          if (isReload == true) {
            isReload = false;
            return;
          }
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
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override 
  Widget build(BuildContext buildContext) {
    return RichText(
        text: TextSpan(
          style: textStyle,
          children: listTexts.map((text) {
            return TextSpan(
              text: text.content,
              style: text.isPlayed ? TextStyle(color: hexColor) : null,
            );
          }).toList()
        )
      );
  }
}