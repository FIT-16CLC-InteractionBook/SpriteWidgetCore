import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class IBSound extends StatefulWidget {
  @override
  _IBSoundState createState() => _IBSoundState();
}

class _IBSoundState extends State<IBSound> {
  AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    AudioPlayer.setIosCategory(IosCategory.playback);
    _player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
