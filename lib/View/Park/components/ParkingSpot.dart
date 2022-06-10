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
        builder: (context) => ModalSheetFillSpot());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: lote.streamSpots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var l = snapshot.data!.docs
              .map((e) => Spot.fromJson(e.data() as Map<String, dynamic>))
              .toList()
            ..sort(((a, b) => a.number.compareTo(b.number)));

          return GridView.builder(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: l.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
              itemBuilder: (context, index) {
                var vaga = l[index];
                return InkWell(
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
                          child:
                              // Obx(() =>
                              SelectedSpot(
                                  lote: lote.name,
                                  vaga: vaga.number,
                                  isFilled: vaga.vagaPreenchida.value)
                          // Container(
                          //   color: vaga.vagaPreenchida.value ? Colors.green.shade300 : Colors.transparent,
                          //   child: Text(
                          //     "${lote.id} ${vaga.id}",
                          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          // ),
                          ),
                    ),
                  ),
                );
              });
          // ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: 9,
          //     itemBuilder: (context, index) {
          //       return SizedBox(
          //           height: 60,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                   decoration: BoxDecoration(
          //                     border: Border(
          //                       top: BorderSide(color: Colors.grey),
          //                       bottom: BorderSide(color: Colors.grey),
          //                     ),
          //                   ),
          //                   height: 60,
          //                   width: 120,
          //                   child: Center(
          //                     child: Text("A$index"),
          //                   )),
          //               VerticalDivider(
          //                 width: 0,
          //                 thickness: 2,
          //                 indent: 0,
          //                 endIndent: 0,
          //                 color: Colors.grey,
          //               ),
          //               Container(
          //                 decoration: BoxDecoration(
          //                   border: Border(
          //                     top: BorderSide(color: Colors.grey),
          //                     bottom: BorderSide(color: Colors.grey),
          //                   ),
          //                 ),
          //                 height: 60,
          //                 width: 120,
          //                 child: Column(
          //                   children: [],
          //                 ),
          //               ),
          //             ],
          //           ));
          //     });
        });
  }
}
