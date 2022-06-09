import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Database/FirestoreDb.dart';
import 'package:park_do_jao/Models/EntradaSaida.dart';

class ReportViewModel extends GetxController {
  var listEntradaSaidas = <EntradaSaida>[].obs;
  DateTime searchDate = DateTime.now();
  DateTime initialSearchDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

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
