import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/Database/FirestoreDb.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/Models/Spot.dart';

class ParkViewModel extends GetxController {
  List<Lote> lotes = [];

  var operacaoSelecionada = TipoOperacao.entrada.obs;
  var vaga = 0.obs;
  var vagaSelecionada = Spot("", 0).obs;

  ParkViewModel() {
    getLotes();
    // FirestoreDb.addLotes(lotes);
  }

  getLotes() async {
    FirestoreDb.getLotes().then((QuerySnapshot value) {
      value.docs.forEach((element) {
        Lote l = Lote.fromJson(element.data() as Map<String, dynamic>);
        l.id = element.id;
        l.spots = getSpots(l.id);
        lotes.add(l);
      });
      lotes.sort(((a, b) => a.name.compareTo(b.name)));
    });
  }

  getSpots(String idLote) {
    var spostAuxiliar = <Spot>[];
    FirestoreDb.getSpotsByLote(idLote).then((QuerySnapshot value) {
      value.docs.forEach((element) {
        Spot s = Spot.fromJson(element.data() as Map<String, dynamic>);
        spostAuxiliar.add(s);
      });
    });
    return spostAuxiliar;
  }

  updateFreeSpots(Lote lote) {
    var vagasPreenchidas = [];
    lote.spots.forEach((element) {
      if (element.vagaPreenchida.value) vagasPreenchidas.add(element);
    });
    lote.freeSpots.value = lote.spots.length - vagasPreenchidas.length;
  }

  saveSpot() async {
    await FirestoreDb.registerEntradaSaida(vagaSelecionada.value, operacaoSelecionada.value);
    // await FirestoreDb.updateSpotStatus(vagaSelecionada.value);
  }

  ///Lote A = 0
  ///Lote B = 1
  ///Lote C = 2
  ///Lote D = 3
  var lote = [].obs;
}
