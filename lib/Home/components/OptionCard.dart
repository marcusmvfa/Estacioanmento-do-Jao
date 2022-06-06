import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Park/ParkView.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const ParkView()),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: const [Icon(Icons.directions_car), Text("Entrada")],
          ),
        ),
      ),
    );
  }
}
