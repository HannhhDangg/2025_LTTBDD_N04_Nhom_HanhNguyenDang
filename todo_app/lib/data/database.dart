import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // referencen our box
late final Box _myBox;

ToDoDataBase() {
  _myBox = Hive.box('mybox');
}

  // run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Khởi tạo nhiệm vụ mới của bạn", false],
      ["6 giờ dậy", false],
    ];
  }

  //load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
