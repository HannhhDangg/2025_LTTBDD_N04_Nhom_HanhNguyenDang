import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/widgets/dialog_box.dart';
import '../widgets/todo_tile.dart';
import 'infor_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  int _selectedIndex = 0; // 0 = home, 1 = info

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      db.toDoList.add([_controller.text.trim(), false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void editTask(int index) {
    _controller.text = db.toDoList[index][0];

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            if (_controller.text.trim().isEmpty) return;
            setState(() {
              db.toDoList[index][0] = _controller.text
                  .trim();
              _controller.clear();
            });
            Navigator.of(context).pop();
            db.updateDatabase();
          },
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      //Trang chính (Danh sách nhiệm vụ)
      Scaffold(
        backgroundColor: const Color(0xFFE3F2FD),
        body: SafeArea(
          child: Column(
            children: [
              // Tiêu đề
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: const Center(
                  child: Text(
                    "NHIỆM VỤ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              // Nội dung chính
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "Danh sách công việc của bạn",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Danh sách nhiệm vụ
                      Expanded(
                        child: db.toDoList.isEmpty
                            ? const Center(
                                child: Text(
                                  "Chưa có công việc nào, lên lịch hôm nay thôi nào!",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                  textAlign:
                                      TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    db.toDoList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () =>
                                        editTask(index),
                                    child: ToDoTile(
                                      taskName: db
                                          .toDoList[index][0],
                                      taskCompleted: db
                                          .toDoList[index][1],
                                      onChanged: (value) =>
                                          checkBoxChanged(
                                            value,
                                            index,
                                          ),
                                      deleteFunction:
                                          (context) =>
                                              deleteTask(
                                                index,
                                              ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Nút thêm nhiệm vụ
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FloatingActionButton(
            onPressed: createNewTask,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            child: const Icon(Icons.add, size: 28),
          ),
        ),
      ),

      // Trang thông tin
      const InforPage(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFE3F2FD),
      body: pages[_selectedIndex],

      // Thanh điều hướng dưới
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 0,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Thông tin nhóm',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
