import 'package:flutter/material.dart'; //goi cung cap widget để xây dựng thư viện

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(title: Center(child: Text('TO DO')), elevation: 0),
    );
  }
}
