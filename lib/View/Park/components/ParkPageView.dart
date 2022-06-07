import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/View/Park/components/ParkingSpot.dart';
import 'package:park_do_jao/View/Park/components/TopPageWidget.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class ParkPageView extends StatelessWidget {
  ParkPageView({Key? key}) : super(key: key);
  ParkViewModel viewModel = Get.find();

  gerarLote(index) {
    switch (index) {
      case 0:
        viewModel.lotes.add(Lote("A", index));
        break;
      case 1:
        viewModel.lotes.add(Lote("B", index));
        break;
      case 2:
        viewModel.lotes.add(Lote("C", index));
        break;
      case 3:
        viewModel.lotes.add(Lote("D", index));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          children: [
            TopPageWidget(viewModel.lotes[index]),
            ParkingSpot(viewModel.lotes[index]),
            Center(
              child: Obx(
                () => Text(
                    "Lote ${viewModel.vagaSelecionada.value.lot}, Vaga ${viewModel.vagaSelecionada.value.number}"),
              ),
            )
          ],
        );
      },
    );
  }
}
