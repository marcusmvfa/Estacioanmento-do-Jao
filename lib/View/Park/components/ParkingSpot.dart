// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/Models/Spot.dart';
import 'package:park_do_jao/View/Others/SpotFilledDialog.dart';
import 'package:park_do_jao/View/Park/components/ModalSheetFillSpot.dart';
import 'package:park_do_jao/View/Park/components/SelectedSpot.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class ParkingSpot extends StatelessWidget {
  ParkingSpot(this.lote, {Key? key}) : super(key: key);
  Lote lote;
  ParkViewModel viewModel = Get.find();

  fillSpot(Spot vaga, BuildContext context) async {
    if (vaga.vagaPreenchida.value == false) {
      viewModel.vagaSelecionada.value = vaga;
      showBottomSheet(context);
    } else if (vaga.vagaPreenchida.value == true) {
      viewModel.vagaSelecionada.value = vaga;
      showBottomSheet(context);
    }
  }

  showBottomSheet(context) async {
    await showModalBottomSheet(
        backgroundColor: Color(0xffF7F7F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        isScrollControlled: true,
        builder: (context) => ModalSheetFillSpot());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: lote.spots.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
          itemBuilder: (context, index) {
            var vaga = lote.spots[index];
            return Material(
              key: Key("spot$index"),
              child: InkWell(
                onTap: () async {
                  fillSpot(vaga, context);
                },
                child: GridTile(
                  child: Container(
                    // margin: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      color: vaga.vagaPreenchida.value ? Color(0xbbFF858A) : Color(0xaa80ED99),
                      border: Border(
                        top: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black),
                        left: index % 2 == 1 ? BorderSide(color: Colors.black) : BorderSide.none,
                      ),
                    ),
                    child: Center(
                        child: SelectedSpot(
                            key: Key('selectedSpot'),
                            lote: lote.name,
                            vaga: vaga.number,
                            isFilled: vaga.vagaPreenchida.value)),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
