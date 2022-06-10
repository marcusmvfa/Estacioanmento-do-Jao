import 'package:flutter/material.dart';
import 'package:park_do_jao/View/Home/components/OptionList.dart';
import 'package:park_do_jao/View/Home/components/TopNameWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDBDFFD),
      appBar: AppBar(
        backgroundColor: const Color(0xff9BA3EB),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const TopNameWidget(),
          const Text(
            'Selecione uma opção ',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const OptionList(),
        ],
      ),
    );
  }
}
