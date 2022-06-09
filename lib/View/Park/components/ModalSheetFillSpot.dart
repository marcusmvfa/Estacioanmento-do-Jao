import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/Models/EntradaSaida.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/View/Park/components/SelectedSpot.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class ModalSheetFillSpot extends StatefulWidget {
  const ModalSheetFillSpot({Key? key}) : super(key: key);

  @override
  State<ModalSheetFillSpot> createState() => _ModalSheetFillSpotState();
}

class _ModalSheetFillSpotState extends State<ModalSheetFillSpot> {
  TextEditingController placaController = TextEditingController();
  TextEditingController horaEntradaController = TextEditingController();
  TextEditingController horaSaidaController = TextEditingController();
  ParkViewModel viewModel = Get.find();
  late Lote loteSelecionado;
  bool firstOpen = true;

  getLoteSelecionado() async {
    if (firstOpen) {
      loteSelecionado = viewModel.lotes
          .where(
            (element) => element.id == viewModel.vagaSelecionada.value.lot,
          )
          .first;
      await viewModel.getEntradaSaida(loteSelecionado.id, viewModel.vagaSelecionada.value.id);
      firstOpen = false;
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    await getLoteSelecionado();
    placaController.text = viewModel.entradaSaida.placa;
    horaEntradaController.text = viewModel.entradaSaida.entry;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Center(
            child: Text(
              "Dados da vaga",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Vaga selecionada:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          ),
          SelectedSpot(
            lote: loteSelecionado.name,
            isFilled: viewModel.vagaSelecionada.value.vagaPreenchida.value,
          )
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Placa:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: placaController,
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 7,
                    style: const TextStyle(
                      letterSpacing: 2,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Placa do Veículo",
                      focusColor: Color(0xffD3DEDC),
                    ),
                  ),
                ),
                const Spacer()
              ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(children: [
            const Expanded(
              flex: 1,
              child: Text(
                "Hora da Entrada:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                  controller: horaEntradaController,
                  decoration: const InputDecoration(
                    labelText: "Horário da Entrada",
                    focusColor: Color(0xffD3DEDC),
                  ),
                  readOnly: true,
                  onTap: () async {
                    await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.input,
                            context: context,
                            initialTime: TimeOfDay.now())
                        .then((value) {
                      if (value != null) {
                        horaEntradaController.text = "${value.hour}:${value.minute}";
                        viewModel.vagaSelecionada.value.horaEntrada = value.format(context);
                      }
                    });
                  }),
            ),
            const Spacer()
          ]),
        ),
        if (viewModel.operacaoSelecionada.value == TipoOperacao.saida)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              const Expanded(
                flex: 1,
                child: Text(
                  "Hora da Saída:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextFormField(
                    controller: horaSaidaController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Horário da Saída",
                      focusColor: Color(0xffD3DEDC),
                    ),
                    onTap: () async {
                      await showTimePicker(
                              initialEntryMode: TimePickerEntryMode.input,
                              context: context,
                              initialTime: TimeOfDay.now())
                          .then((value) {
                        if (value != null) {
                          horaSaidaController.text = value.format(context);
                          viewModel.vagaSelecionada.value.horaSaida = value.format(context);
                          viewModel.entradaSaida.out = value.format(context);
                          debugger();
                        }
                      });
                    }),
              ),
              const Spacer()
            ]),
          ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 100,
          child: ElevatedButton(
            onPressed: () async {
              viewModel.vagaSelecionada.value.placa = placaController.text;
              await viewModel.saveSpot();
              Navigator.of(context).pop();
            },
            child: const Text(
              "Preencher Vaga",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}

// class ModalSheetFillSpot extends StatelessWidget {
//   ModalSheetFillSpot({Key? key}) : super(key: key);
//   TextEditingController placaController = TextEditingController();
//   TextEditingController horaEntradaController = TextEditingController();
//   TextEditingController horaSaidaController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     ParkViewModel viewModel = Get.find();
//     return Container(
//       padding: const EdgeInsets.all(0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Text(
//             "Dados para preencher a vaga",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Row(children: [
//           const Padding(
//             padding: EdgeInsets.all(16),
//             child: Text("Vaga selecionada:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
//           ),
//           SelectedSpot()
//         ]),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Expanded(
//                   child: Text(
//                     "Placa:",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: TextFormField(
//                     controller: placaController,
//                     textCapitalization: TextCapitalization.characters,
//                     maxLength: 7,
//                     style: TextStyle(
//                       letterSpacing: 2,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: "Placa do Veículo",
//                       focusColor: const Color(0xffD3DEDC),
//                     ),
//                   ),
//                 ),
//                 Spacer()
//               ]),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(children: [
//             const Expanded(
//               flex: 1,
//               child: Text(
//                 "Hora da Entrada:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: TextFormField(
//                   controller: horaEntradaController,
//                   decoration: InputDecoration(
//                     labelText: "Horário da Entrada",
//                     focusColor: const Color(0xffD3DEDC),
//                   ),
//                   onTap: () async {
//                     await showTimePicker(
//                             initialEntryMode: TimePickerEntryMode.input,
//                             context: context,
//                             initialTime: TimeOfDay.now())
//                         .then((value) {
//                       if (value != null) {
//                         horaEntradaController.text = value.toString();
//                         viewModel.vagaSelecionada.value.horaEntrada = value.format(context);
//                       }
//                     });
//                   }),
//             ),
//             const Spacer()
//           ]),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(children: [
//             const Expanded(
//               flex: 1,
//               child: Text(
//                 "Hora da Saída:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: TextFormField(
//                   controller: horaSaidaController,
//                   decoration: InputDecoration(
//                     labelText: "Horário da Saída",
//                     focusColor: const Color(0xffD3DEDC),
//                   ),
//                   onTap: () {
//                     showTimePicker(
//                             initialEntryMode: TimePickerEntryMode.input,
//                             context: context,
//                             initialTime: TimeOfDay.now())
//                         .then((value) {
//                       if (value != null) {
//                         horaSaidaController.text = value.toString();
//                         viewModel.vagaSelecionada.value.horaSaida = value.format(context);
//                       }
//                     });
//                   }),
//             ),
//             const Spacer()
//           ]),
//         ),
//         SizedBox(
//           height: 16,
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           height: 100,
//           child: ElevatedButton(
//             onPressed: () async {
//               viewModel.vagaSelecionada.value.placa = placaController.text;
//               await viewModel.saveSpot();
//               Navigator.of(context).pop();
//             },
//             child: const Text(
//               "Preencher Vaga",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
