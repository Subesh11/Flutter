import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:note_adv/datepicker.dart';
import 'package:note_adv/internal.dart';
import 'package:note_adv/models/notedb.dart';
import 'package:note_adv/models/notes.dart';
import 'package:note_adv/showdia.dart';
import 'package:note_adv/theam.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showWidget = false;
  final ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  bool focus = false;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController_sun = TextEditingController();
  TextEditingController textEditingController_date = TextEditingController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.offset > 10 && !showWidget) {
        setState(() {
          showWidget = true;
        });
      } else if (scrollController.offset <= 10 && showWidget) {
        setState(() {
          focus = false;
          showWidget = false;
        });
      }
    });
    focusNode.addListener(() {
      setState(() {
        focus = !focus;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void readnotes() {
    context.watch<Notedb>().fetchNotes();
  }

  Future<DateTime?> pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    final notedatabase = context.watch<Notedb>();
    List<Note> currentNote = notedatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Reminder")),
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
        width: 200,
        // 👈 attach drawer here
        child: ListView(
          padding: EdgeInsets.zero, // removes default top padding
          children: [
            Container(
              height: 80,
              child: const DrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 62, 65, 68),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.person_rounded),
                      Text(
                        'Subesh Gumanju',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Text("Theme"),
              trailing: Switch(
                value: Theme == darkMode,
                onChanged: (value) {
                  setState(() {
                    Theme:
                    darkMode;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (focus) {
            FocusScope.of(context).unfocus();
          }
          // This will remove focus from the SearchBar
        },
        child: Column(
          children: [
            SizedBox(height: 20),
            // Use the showWidget state to toggle a more visible widget
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: showWidget
                  ? SizedBox(
                      height: 50,
                      width: focus ? 400 : 200,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SearchBar(
                                autoFocus: false,
                                focusNode: focusNode,
                                leading: Icon(Icons.search),
                                hintText: "Your Reminder",
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(), // Hides the widget and makes it shrink
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: currentNote
                    .length, // Increased itemCount to enable scrolling
                itemBuilder: (BuildContext context, int index) {
                  final note = currentNote[index];

                  return Slidable(
                    key: ValueKey(note.id),
                    endActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            context.read<Notedb>().deleteNote(note.id);
                          },
                          backgroundColor: const Color.fromARGB(
                            255,
                            52,
                            52,
                            52,
                          ),
                          icon: Icons.delete,
                          label: "Delete",
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Cards(
                            id: note.id,
                            title: note.text,
                            subtitle: note.subtext.toString(),
                            time: note.datetime,
                          ),
                        );
                      },
                      title: Text(
                        note.text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // trailing: Text(note.datetime.toString()),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMd().format(
                              note.datetime,
                            ), // e.g. Sep 2, 2025
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            DateFormat.jm().format(
                              note.datetime,
                            ), // e.g. 3:03 PM
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      subtitle: Text(note.subtext.toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 280,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: 300,
                        height: 300,

                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  0,
                                  20,
                                  0,
                                  10,
                                ),
                                child: Text("Reminder"),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  8,
                                  12,
                                  0,
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        // Default border when unfocused
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        // Border when focused
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: textEditingController_sun,
                                      decoration: InputDecoration(
                                        // Default border when unfocused
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        // Border when focused
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DateTimeInputField(
                                      controller: textEditingController_date,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 130),
                                  TextButton(
                                    onPressed: () {
                                      context.read<Notedb>().addNote(
                                        textEditingController.text,
                                        textEditingController_sun.text,
                                        DateTime.parse(
                                          textEditingController_date.text,
                                        ),
                                      );

                                      Navigator.pop(context);
                                    },
                                    child: Text("Save"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
                // AlertDialog(actions: [Text("data")]);
                // Dialog(child: TextField(controller: textEditingController));
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
