import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:note_adv/models/notedb.dart';
import 'package:provider/provider.dart';

class Cards extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  final DateTime time;

  const Cards({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  late AudioPlayer _player;
  late Duration currenttime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _loadAsset();

    // initialize countdown
    currenttime = widget.time.difference(DateTime.now());

    // start timer
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        currenttime = widget.time.difference(DateTime.now());

        // stop timer and play audio when countdown reaches zero
        if (currenttime.isNegative || currenttime.inSeconds == 0) {
          timer?.cancel();
          context.read<Notedb>().deleteNote(widget.id);
          currenttime = Duration.zero;
          _player.play(); // play audio once
        }
      });
    });
  }

  // load audio asset
  Future<void> _loadAsset() async {
    try {
      await _player.setAsset('assets/alarm.mp3');
    } catch (e) {
      print('Error loading asset: $e');
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // cleanup timer
    _player.dispose(); // dispose audio player
    super.dispose();
  }

  // format Duration to human-readable string
  String formatDuration(Duration duration) {
    final int days = duration.inDays;
    final int hours = duration.inHours % 24;
    final int minutes = duration.inMinutes % 60;
    final int seconds = duration.inSeconds % 60;

    return "$days days, $hours hours, $minutes min, $seconds sec";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.subtitle),
          const SizedBox(height: 8),
          Text(
            formatDuration(currenttime),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // close dialog
          },
          child: const Text("Close"),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.pop(context); // Close dialog
        //   },
        //   child: const Text("Edit"),
        // ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Edit"),
        ),
      ],
    );
  }
}
