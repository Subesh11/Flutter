import 'package:hive_ce/hive.dart';

class ToDoDatabase {
  List tasks = [];
  final _myBox = Hive.box("mybox");
  void createInitialData() {
    tasks = [];
  }

  void loadData() {
    tasks = _myBox.get("ToDoList");
  }

  void updateDatabase() {
    _myBox.put("ToDoList", tasks);
  }
}
