import 'package:flutter/material.dart';

class Dolist extends StatelessWidget {
  const Dolist({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text("data"),
      ),
    );
  }
}
