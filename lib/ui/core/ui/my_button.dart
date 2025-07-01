import 'package:flutter/material.dart';
import 'package:state_flutter/ui/core/themes/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.primary,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
