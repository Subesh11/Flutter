import 'package:flutter/material.dart';
import 'package:prov/home.dart';
import 'package:prov/theam.dart';
import 'package:prov/themeprov.dart';
import 'package:provider/provider.dart';
import 'package:prov/provi.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
        ChangeNotifierProvider(create: (context) => Themeprov()),
        // Add more providers as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Themeprov>(
      builder: (context, themeProv, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeProv.theamdata,
          home: Home(title: 'Flutter Demo'),
        );
      },
    );
  }
}
