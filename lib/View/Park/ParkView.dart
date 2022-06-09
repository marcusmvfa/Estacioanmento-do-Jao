import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/View/Park/components/ParkPageView.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class ParkView extends StatelessWidget {
  ParkView({Key? key}) : super(key: key);
  ParkViewModel viewModel = Get.find();
  getTipoOperacao() {
    var str = "";
    if (viewModel.operacaoSelecionada.value == TipoOperacao.entrada) {
      str = "Entrada";
    } else {
      str = "Saída";
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTipoOperacao()),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ParkPageView(),
      ),
    );
  }
}
