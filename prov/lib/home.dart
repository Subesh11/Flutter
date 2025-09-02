import 'package:flutter/material.dart';
import 'package:prov/provi.dart';
import 'package:prov/themeprov.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, value, child) => (Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                value.count.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                onPressed: () {
                  // This is the correct way to access a provider from an event handler.
                  // Setting listen: false prevents the 'rebuild' error.
                  Provider.of<Themeprov>(context, listen: false).toggletheme();
                  print("object");
                },
                child: const Text("Toggle For Modes"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: value.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )),
    );
  }
}
