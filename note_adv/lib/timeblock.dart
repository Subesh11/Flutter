import 'package:flutter/material.dart';

class Timeblock extends StatelessWidget {
  const Timeblock({super.key, required this.tm});

  final int tm;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(tm.toString(), style: TextStyle(fontSize: 30)),
    );
  }
}
