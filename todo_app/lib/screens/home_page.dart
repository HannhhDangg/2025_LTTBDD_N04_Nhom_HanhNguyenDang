import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/l10n/app_localizations.dart';
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
    final local = AppLocalizations.of(context)!;

    final List<Widget> pages = [
      //Trang chính
      Scaffold(
        backgroundColor: const Color(0xFFE3F2FD),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //English Flag
                    GestureDetector(
                      onTap: () => MyApp.setLocale(
                        context,
                        const Locale('en'),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'en'
                              ? Border.all(
                                  color: Colors.blueAccent,
                                  width: 2.5,
                                )
                              : null,
                          boxShadow:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'en'
                              ? [
                                  BoxShadow(
                                    color: Colors.blueAccent
                                        .withOpacity(0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : [],
                        ),
                        child: Image.asset(
                          'imgs/en.png',
                          width:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'en'
                              ? 38
                              : 32,
                          height:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'en'
                              ? 38
                              : 32,
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Vietnamese Flag
                    GestureDetector(
                      onTap: () => MyApp.setLocale(
                        context,
                        const Locale('vi'),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'vi'
                              ? Border.all(
                                  color: Colors.blueAccent,
                                  width: 2.5,
                                )
                              : null,
                          boxShadow:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'vi'
                              ? [
                                  BoxShadow(
                                    color: Colors.blueAccent
                                        .withOpacity(0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : [],
                        ),
                        child: Image.asset(
                          'imgs/vn.png',
                          width:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'vi'
                              ? 38
                              : 32,
                          height:
                              Localizations.localeOf(
                                    context,
                                  ).languageCode ==
                                  'vi'
                              ? 38
                              : 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                child: Center(
                  child: Text(
                    local.homeTitle,
                    style: const TextStyle(
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
                      Center(
                        child: Text(
                          local.tabHome,
                          style: const TextStyle(
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
                            ? Center(
                                child: Text(
                                  local.emptyList,
                                  style: const TextStyle(
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

      const InforPage(),
    ];

    //  bottom navigation
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFE3F2FD),
      body: pages[_selectedIndex],

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
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: local.tabHome,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: local.tabInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
