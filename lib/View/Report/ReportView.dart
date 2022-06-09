import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/ViewModel/ReportViewModel.dart';

class ReportView extends StatelessWidget {
  ReportView({Key? key}) : super(key: key);
  TextEditingController dataBuscaController = TextEditingController();
  ReportViewModel viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Relatório")),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Text("Data de busca"),
                Expanded(
                  child: TextFormField(
                    controller: dataBuscaController,
                    readOnly: true,
                    onTap: () => showDatePicker(
                            context: context,
                            initialDate: viewModel.initialSearchDate,
                            firstDate: viewModel.initialSearchDate,
                            lastDate: DateTime.now())
                        .then((value) {
                      if (value != null) {
                        viewModel.searchDate = value;
                        viewModel.searchEntradaSaida();
                      }
                    }),
                  ),
                )
              ],
            ),
            Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.listEntradaSaidas.value.length,
                itemBuilder: (context, index) {
                  var entradaSaida = viewModel.listEntradaSaidas.value[index];
                  return Container(
                    child:
                        Row(children: [Text(entradaSaida.entry), Text(entradaSaida.out ?? "NaN")]),
                  );
                }))
          ]),
        ),
      ),
    );
  }
}
