import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';

class TopPageWidget extends StatelessWidget {
  TopPageWidget(this.lot, {Key? key}) : super(key: key);
  Lote lot;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF9F9F9),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4, right: 4),
                child: Text(
                  lot.id,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Obx(
                () => Text(
                  "${lot.freeSpots} Vagas Livres",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
              ),
            ]),
      ),
    );
  }
}
