import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class SelectedSpot extends StatelessWidget {
  SelectedSpot({Key? key, this.vaga, this.lote}) : super(key: key);
  ParkViewModel viewModel = Get.find();
  int? vaga;
  String? lote;
  @override
  Widget build(BuildContext context) {
    vaga = vaga ?? viewModel.vagaSelecionada.value.number;
    lote = lote ?? viewModel.vagaSelecionada.value.lot;
    return Card(
      color: const Color(0xffD3DEDC),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          "$lote $vaga",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
