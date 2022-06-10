import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/Database/FirestoreDb.dart';
import 'package:park_do_jao/Models/EntradaSaida.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/Models/Spot.dart';

class ParkViewModel extends GetxController {
  List<Lote> lotes = [];

  var operacaoSelecionada = TipoOperacao.entrada.obs;
  var vaga = 0.obs;
  var vagaSelecionada = Spot("", 0).obs;
  var loteSelecionado = Lote("", 0);
  late EntradaSaida entradaSaida;

  ParkViewModel() {
    getLotes();
    // FirestoreDb.addLotes(lotes);
  }

  getLotes() async {
    FirestoreDb.getLotes().then((QuerySnapshot value) {
      value.docs.forEach((element) async {
        Lote l = Lote.fromJson(element.data() as Map<String, dynamic>);
        l.id = element.id;
        l.streamSpots = getStream(l.id);
        // l.spots = await getSpots(l.id);
        // l.spots.sort(((a, b) => a.number.compareTo(b.number)));
        lotes.add(l);
      });
      lotes.sort(((a, b) => a.name.compareTo(b.name)));
    });
  }

  getSpots(String idLote) async {
    var spostAuxiliar = <Spot>[];
    await FirestoreDb.getSpotsByLote(idLote).then((QuerySnapshot value) {
      value.docs.forEach((element) {
        Spot s = Spot.fromJson(element.data() as Map<String, dynamic>);
        spostAuxiliar.add(s);
      });
    });
    return spostAuxiliar;
  }

  getStream(String idLote) {
    return FirebaseFirestore.instance
        .collection('spots')
        .where('lote', isEqualTo: idLote)
        .snapshots();
  }

  Future getEntradaSaida(String idLote, String idSpot) async {
    loteSelecionado = lotes.where((element) => element.id == idLote).first;
    await FirestoreDb.getEntradaSaida(idLote, idSpot).then((QuerySnapshot value) {
      var aux = <EntradaSaida>[];
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          EntradaSaida es = EntradaSaida.fromJson(element.data() as Map<String, dynamic>);
          aux.add(es);
        });
        aux.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        if (aux.last.out == null) {
          entradaSaida = aux.last;

          vagaSelecionada.value.horaEntrada = entradaSaida.entry;
        } else {
          entradaSaida = EntradaSaida("", "", "", "", "", "");
        }
      } else {
        entradaSaida = EntradaSaida("", "", "", "", "", "");
      }
    });
  }

  getTotalTime(String entry, String out) {
    var entryHour = int.parse(entry.substring(0, 2));
    var entryMinute = int.parse(entry.substring(3, 5));
    DateTime entra = DateTime(2022, 6, 1, entryHour, entryMinute);

    var outHour = int.parse(out.substring(0, 2));
    var outMinute = int.parse(out.substring(3, 5));
    DateTime sai = DateTime(2022, 6, 1, outHour, outMinute);
    return sai.difference(entra).inMinutes.toString();
  }

  updateFreeSpots(Lote lote) {
    var vagasPreenchidas = [];
    lote.spots.forEach((element) {
      if (element.vagaPreenchida.value) vagasPreenchidas.add(element);
    });
    lote.freeSpots.value = lote.spots.length - vagasPreenchidas.length;
  }

  saveSpot() async {
    if (vagaSelecionada.value.vagaPreenchida.value == false) {
      EntradaSaida entradaSaida = EntradaSaida(
          vagaSelecionada.value.id,
          vagaSelecionada.value.horaEntrada!,
          vagaSelecionada.value.placa,
          vagaSelecionada.value.lot,
          loteSelecionado.name,
          vagaSelecionada.value.number.toString());
      await FirestoreDb.registerEntrada(entradaSaida, operacaoSelecionada.value);
    } else {
      entradaSaida.totalTime = getTotalTime(entradaSaida.entry, entradaSaida.out!);
      await FirestoreDb.registerSaida(entradaSaida, operacaoSelecionada.value);
    }
    vagaSelecionada.value.vagaPreenchida.value = !vagaSelecionada.value.vagaPreenchida.value;
    await FirestoreDb.updateSpotStatus(vagaSelecionada.value);
  }

  ///Lote A = 0
  ///Lote B = 1
  ///Lote C = 2
  ///Lote D = 3
  var lote = [].obs;
}
