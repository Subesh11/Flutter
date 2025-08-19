import 'package:hive/hive.dart';

class ToDoDatabase {
  List tasks = [];
  final _myBox = Hive.box("mybox");
  void createInitialData() {
    tasks = [
      ["Create App", true],
      ["USe", false],
      ["Fan", false],
      ["Student", true],
    ];
  }

  void loadData() {
    tasks = _myBox.get("ToDoList");
  }

  void updateDatabase() {
    _myBox.put("ToDoList", tasks);
  }
}
