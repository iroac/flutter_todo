import 'package:flutter/material.dart';
import 'package:state_flutter/ui/core/ui/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[300],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Add a new task',
              ),
            ),

            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(onPressed: onCancel, text: 'Cancel'),
                MyButton(onPressed: onSave, text: 'Save'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
