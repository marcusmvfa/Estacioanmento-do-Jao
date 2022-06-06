// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';

class ParkingSpot extends StatelessWidget {
  ParkingSpot(this.lote, {Key? key}) : super(key: key);
  Lote lote;
  ParkViewModel viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        itemCount: lote.spots.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
        itemBuilder: (context, index) {
          var vaga = lote.spots[index];
          return InkWell(
            onTap: () {
              vaga.vagaPreenchida.value = !vaga.vagaPreenchida.value;
              viewModel.updateFreeSpots(lote);
            },
            child: GridTile(
              child: Container(
                // margin: EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                    left: index % 2 == 1 ? BorderSide(color: Colors.grey) : BorderSide.none,
                  ),
                ),
                child: Center(
                  child: Obx(
                    () => Container(
                      color: vaga.vagaPreenchida.value ? Colors.green.shade300 : Colors.transparent,
                      child: Text(
                        "${lote.id} ${vaga.id}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
  }
}
