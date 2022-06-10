import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Database/FirestoreDb.dart';
import 'package:park_do_jao/Models/EntradaSaida.dart';
import 'package:intl/intl.dart';

class ReportViewModel extends GetxController {
  var listEntradaSaidas = <EntradaSaida>[].obs;
  DateTime searchDate = DateTime.now();
  DateTime initialSearchDate = DateTime.now();
  DateTime firstSearchDate = DateTime.now().subtract(Duration(days: 7));

  String getSearchDateFormatted() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  searchEntradaSaida() async {
    await FirestoreDb.searchEntradaSaida(searchDate).then((QuerySnapshot value) {
      listEntradaSaidas.clear();
      value.docs.forEach((element) {
        EntradaSaida s = EntradaSaida.fromJson(element.data() as Map<String, dynamic>);
        listEntradaSaidas.add(s);
      });
    });
  }
}
