import 'package:flutter/material.dart';
import 'package:todo_app/widgets/button_save.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Thêm nhiệm vụ mới",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                SaveButton(text: "Lưu", onPressed: onSave),

                const SizedBox(width: 8),

                //cancel Button
                SaveButton(
                  text: "Huỷ",
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),

        //button: save + cancel
      ),
    );
  }
}
