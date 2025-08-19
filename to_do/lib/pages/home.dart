import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/database/database.dart';
import 'package:to_do/util/listtiles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController addTask = TextEditingController();
  final _myBox = Hive.box("mybox");
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState() {
    if (_myBox.get("ToDoList") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  checkboxChanged(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = !db.tasks[index][1];
      db.updateDatabase();
    });
  }

  delList(int index) {
    setState(() {
      db.tasks.removeAt(index);
      db.updateDatabase();
    });
  }

  adddTask() {
    setState(() {
      db.tasks.add([addTask.text, false]);
      addTask.clear();
      db.updateDatabase();
    });
    Navigator.of(context).pop();
  }

  popoff() {
    Navigator.of(context).pop();
  }

  onPressed() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
            height: 155,
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(20, 10, 0, 0),
                  child: Text("TODo Task", style: TextStyle(fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextField(
                    controller: addTask,
                    decoration: InputDecoration(
                      hintText: "Your Task Here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: adddTask, child: Text("Save")),
                      TextButton(onPressed: popoff, child: Text("Cancel")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 216, 142),
        title: Center(child: Text("To Do list")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: db.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Tiles(
                    task: db.tasks[index][0],
                    value: db.tasks[index][1],
                    onChanged: (value) => checkboxChanged(value, index),
                    deleteList: (context) => delList(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
