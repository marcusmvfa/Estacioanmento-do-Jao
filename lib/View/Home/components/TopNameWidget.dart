import 'package:flutter/material.dart';

class TopNameWidget extends StatelessWidget {
  const TopNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: const Text(
        "Seja Bem-Vindo, João",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}
