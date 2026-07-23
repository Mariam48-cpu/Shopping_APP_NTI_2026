import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.txt,
    required this.width,
    required this.height,
    required this.color,
    required this.fun,
    required this.borderColor,
    required this.txtColor,
  });
  final String txt;
  final double width;
  final double height;
  final Color color;
  final Color borderColor;
  final Color txtColor;
  final VoidCallback fun;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: .circular(8)),
        backgroundColor: color,
        minimumSize: Size(width, height),
      ),
      child: Text(txt, style: TextStyle(color: txtColor)),
    );
  }
}
