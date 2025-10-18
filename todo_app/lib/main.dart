import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_page.dart';

void main() async {
  // Khởi tạo Hive
  await Hive.initFlutter();

  // Mở box dữ liệu
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor:
              Colors.white, // màu chữ trên AppBar
          centerTitle: true,
        ),
      ),
    );
  }
}
