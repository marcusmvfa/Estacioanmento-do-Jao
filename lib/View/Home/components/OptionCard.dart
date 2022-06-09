import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/View/Park/ParkView.dart';
import 'package:park_do_jao/View/Report/ReportView.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class OptionCard extends StatelessWidget {
  OptionCard(this.tipoOperacao, {Key? key}) : super(key: key);
  final tipoOperacao;

  late ParkViewModel viewModel;

  getIcon() {
    if (tipoOperacao == TipoOperacao.relatorio) {
      return const [
        Icon(
          Icons.my_library_books_outlined,
          size: 32,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Relatório",
          style: TextStyle(fontSize: 24),
        )
      ];
    }
    if (tipoOperacao == TipoOperacao.entrada) {
      return const [
        Icon(
          Icons.arrow_circle_up_outlined,
          size: 32,
        ),
        Text(
          "Entrada",
          style: TextStyle(fontSize: 24),
        )
      ];
    } else {
      return const [
        Icon(
          Icons.arrow_circle_down_outlined,
          size: 32,
        ),
        Text(
          "Saída",
          style: TextStyle(fontSize: 24),
        )
      ];
    }
  }

  callback() {
    viewModel.operacaoSelecionada.value = tipoOperacao;
    if (tipoOperacao == TipoOperacao.relatorio) {
      Get.to(() => ReportView());
    } else {
      Get.to(() => ParkView());
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 100,
      child: InkWell(
        onTap: callback,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: getIcon()),
          ),
        ),
      ),
    );
  }
}
