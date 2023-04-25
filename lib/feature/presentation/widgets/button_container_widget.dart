import 'package:flutter/material.dart';

class ButtonContainerWidget extends StatelessWidget {
  final Color? color;
  final String text;
  final VoidCallback onTap;

  const ButtonContainerWidget(
      {super.key, this.color, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(MediaQuery.of(context).size.width, 45),
      ),
      child: Text(text),
    );
  }
}
