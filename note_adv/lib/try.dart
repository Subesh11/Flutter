import 'package:flutter/material.dart';
import 'package:note_adv/datepicker.dart';
import 'package:note_adv/models/notedb.dart';
import 'package:provider/provider.dart';

void showReminderDialog(BuildContext context) {
  final textEditingController = TextEditingController();
  final textEditingController_sun = TextEditingController();
  final textEditingController_date = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Remider",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                DateTimeInputField(controller: textEditingController_date),
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<Notedb>().addNote(
                          textEditingController.text,
                          textEditingController_sun.text,
                          DateTime.parse(textEditingController_date.toString()),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
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
}
