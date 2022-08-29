
import 'package:flutter/material.dart';

class SuperScript extends StatelessWidget {
  final String text;

  const SuperScript({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 61, 64, 67),
      ),
    );
  }
}
