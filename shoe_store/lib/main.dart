// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoe_store/intro.dart'; // Your main app screen

void main() async {
  // Always call this first
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox("My_box");

  // Set the system UI mode after initialization
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  // Run the app after everything is ready
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The home property directly points to your Intropage
    // since main() already handles the Hive initialization
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intropage(),
    );
  }
}
