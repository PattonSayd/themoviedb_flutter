// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;

  const Input(
      {Key? key,
      required this.controller,
      required this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.blue.shade400, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1))),
      style: const TextStyle(fontSize: 18, color: Colors.black87),
    );
  }
}
