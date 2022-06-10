import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class SelectedSpot extends StatelessWidget {
  SelectedSpot({Key? key, this.vaga, this.lote, this.isFilled}) : super(key: key);
  ParkViewModel viewModel = Get.find();
  int? vaga;
  String? lote;
  bool? isFilled;

  getBackgroundColor() {
    if (isFilled != null && isFilled == true) {
      return Colors.red.shade400;
    } else if (isFilled != null && isFilled == false) {
      return Colors.green.shade400;
    } else {
      return Color(0xff9BA3EB);
    }
  }

  @override
  Widget build(BuildContext context) {
    vaga = vaga ?? viewModel.vagaSelecionada.value.number;
    lote = lote ?? viewModel.vagaSelecionada.value.lot;
    return Card(
      // color: isFilled! ? Colors.amber : Color(0xffD3DEDC),
      color: getBackgroundColor(),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          "$lote $vaga",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
