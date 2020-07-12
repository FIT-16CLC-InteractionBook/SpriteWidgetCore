import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ibcore/interfaces/KaraokeCounterObject.dart';
import 'package:ibcore/interfaces/KaraokeTextObject.dart';
import 'package:just_audio/just_audio.dart';

class IBKaraokeText extends StatefulWidget {
  final List<KaraokeText> listTexts;
  final String highlightColor;
  final TextStyle textStyle;
  // final  Stream<Duration> soundStream;
  final AudioPlayer _player;
  final KaraokeCounterObject kCounterObject;

  IBKaraokeText(this.listTexts, this.highlightColor, this.textStyle, this._player, this.kCounterObject);

  @override
  _IBKaraokeTextState createState() => _IBKaraokeTextState(listTexts, highlightColor, textStyle, _player, kCounterObject);
}

class _IBKaraokeTextState extends State<IBKaraokeText> {
  final List<KaraokeText> listTexts;
  final String highlightColor;
  final TextStyle textStyle;
  // final Stream<Duration> soundStream;
  Color hexColor;
  StreamSubscription<Duration> subscription;
  final AudioPlayer _player;
  final KaraokeCounterObject kCounterObject;

  _IBKaraokeTextState(this.listTexts, this.highlightColor, this.textStyle, this._player, this.kCounterObject);


  @override
  void initState() {
    super.initState();
    String subStringColor = highlightColor.substring(1);
    int convertedColor = int.parse('0xff' + subStringColor);
    hexColor = Color(convertedColor);
    Stream<Duration> soundStream = _player.getPositionStream();
    subscription = soundStream.listen((event) { 
      if (kCounterObject.counter == listTexts.length) {
        kCounterObject.counter = 0;
        kCounterObject.isReload = true;
      }
      var serializedEvent = event.toString();
      var aftercut = serializedEvent.split('.')[0];
      if (kCounterObject.counter < listTexts.length) {
        if (kCounterObject.counter == -1) {
          kCounterObject.counter = kCounterObject.counter + 1;
          return;
        }
        if (aftercut == listTexts[kCounterObject.counter].start && !listTexts[kCounterObject.counter].isPlayed) {
          if (kCounterObject.isReload) {
            kCounterObject.isReload = false;
            return;
          }
          listTexts[kCounterObject.counter].isPlayed = true;
          setState(() {});
          return;
        }
        if (aftercut == listTexts[kCounterObject.counter].end && listTexts[kCounterObject.counter].isPlayed) {
          listTexts[kCounterObject.counter].isPlayed = false;
          setState(() {
            kCounterObject.counter = kCounterObject.counter + 1;
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