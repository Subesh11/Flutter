import 'package:flutter/material.dart';
import 'package:note_adv/intropage.dart';
import 'package:flutter/services.dart';
import 'package:note_adv/models/notedb.dart';
import 'package:note_adv/theam.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await Notedb.initilize();

  runApp(ChangeNotifierProvider(create: (context) => Notedb(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMode,
      debugShowCheckedModeBanner: false,
      home: FadeInDemo(),
    );
  }
}
