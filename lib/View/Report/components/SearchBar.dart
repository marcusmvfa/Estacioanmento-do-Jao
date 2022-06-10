import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/ViewModel/ReportViewModel.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);
  TextEditingController dataBuscaController = TextEditingController();
  ReportViewModel viewModel = Get.find();
  initialSearch() {
    dataBuscaController.text = viewModel.getSearchDateFormatted();
    viewModel.searchEntradaSaida();
  }

  @override
  Widget build(BuildContext context) {
    initialSearch();
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Data de busca",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: dataBuscaController,
              readOnly: true,
              decoration: const InputDecoration(
                  border: InputBorder.none, filled: true, fillColor: Colors.white),
              style: const TextStyle(fontSize: 18),
              onTap: () => showDatePicker(
                      context: context,
                      initialDate: viewModel.initialSearchDate,
                      firstDate: viewModel.firstSearchDate,
                      lastDate: DateTime.now())
                  .then((value) {
                if (value != null) {
                  viewModel.searchDate = value;
                  dataBuscaController.text = viewModel.getSearchDateFormatted();
                  viewModel.searchEntradaSaida();
                }
              }),
            ),
          ),
        )
      ],
    );
  }
}
