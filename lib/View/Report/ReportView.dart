import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/View/Report/components/ListItem.dart';
import 'package:park_do_jao/View/Report/components/SearchBar.dart';
import 'package:park_do_jao/ViewModel/ReportViewModel.dart';

class ReportView extends StatelessWidget {
  ReportView({Key? key}) : super(key: key);
  ReportViewModel viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDBDFFD),
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          "Relatório",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xff9BA3EB),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(children: [
            SearchBar(),
            Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.listEntradaSaidas.value.length,
                itemBuilder: (context, index) {
                  var entradaSaida = viewModel.listEntradaSaidas.value[index];
                  return ListItem(entradaSaida);
                }))
          ]),
        ),
      ),
    );
  }
}
