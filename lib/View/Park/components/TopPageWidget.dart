import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';

class TopPageWidget extends StatelessWidget {
  TopPageWidget(this.lot, {Key? key}) : super(key: key);
  Lote lot;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Text(
                "Lote: ${lot.name}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Obx(
            //   () =>
            Text(
              " Selecione uma vaga",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            // ),
          ]),
    );
  }
}
