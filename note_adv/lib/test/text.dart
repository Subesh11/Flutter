import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableListExample extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // 👈 opens the drawer
            },
          ),
        ),
      ),

      drawer: Drawer(
        // 👈 attach drawer here
        child: ListView(
          padding: EdgeInsets.zero, // removes default top padding
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'My Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// showDialog(
//                           context: context,
//                           builder: (context) => Cards(
//                             id: note.id,
//                             title: note.text,
//                             subtitle: note.subtext.toString(),
//                             time: note.datetime,
//                           ),
//                         );