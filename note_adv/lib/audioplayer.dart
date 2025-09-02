import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:note_adv/timeblock.dart';

class AssetAudioPlayer extends StatefulWidget {
  final int days;
  final int hours;
  final int minutes;
  final int second;
  const AssetAudioPlayer({super.key,required this.days,required this.hours,required this.minutes,required this.second});

  @override
  AssetAudioPlayerState createState() => AssetAudioPlayerState();
}

class AssetAudioPlayerState extends State<AssetAudioPlayer> {
  late AudioPlayer _player;
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int second = 5;

  void startCountdown() {
    int totalSeconds = hours * 3600 + minutes * 60 + second;

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (totalSeconds <= -1) {
        _player.play();
        timer.cancel();
      } 
    });
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _loadAsset();
  }

  Future<void> _loadAsset() async {
    try {
      await _player.setAsset('assets/alarm.mp3');
    } catch (e) {
      print('Error loading asset: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Play Asset Audio')),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startCountdown();
                  },
                  child: Text('Play'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _player.pause();
                  },
                  child: Text('Pause'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Timeblock(tm: hours),
                Timeblock(tm: minutes),
                Timeblock(tm: second),
              ],
            ),
            Row(children: [
              ],
            ),
          ],
        ),
      ),
    );
  }
}
