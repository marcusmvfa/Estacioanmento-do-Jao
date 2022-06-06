import 'package:flutter/material.dart';
import 'package:park_do_jao/Park/components/ParkPageView.dart';

class ParkView extends StatelessWidget {
  const ParkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estacionamento"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ParkPageView(),
      ),
    );
  }
}
