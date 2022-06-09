import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:park_do_jao/Constants/Constants.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/Models/EntradaSaida.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/Models/Spot.dart';

class FirestoreDb {
  static addLotes(List<Lote> loteModel) async {
    for (int i = 0; i < loteModel.length; i++) {
      var map = [{}];
      loteModel[i].spots.forEach((element) {
        map.add(element.toJson());
      });

      await firebaseFirestore
          .collection('lotes')
          .add({'name': loteModel[i].name, 'createdAt': Timestamp.now()}).then((value) async {
        for (int i = 0; i < 10; i++) {
          addSpots(
            Spot(value.id, i),
          );
        }
        firebaseFirestore.collection('lotes').doc(value.id).update({'id': value.id});
      });
    }
  }

  static addSpots(Spot spotModel) async {
    await firebaseFirestore.collection('spots').add({
      'number': spotModel.number,
      'createdAt': Timestamp.now(),
      'entryTime': spotModel.horaEntrada,
      'outTime': spotModel.horaSaida,
      'placa': spotModel.placa,
      'lote': spotModel.lot,
    }).then((value) {
      firebaseFirestore.collection('spots').doc(value.id).update({'id': value.id});
    });
  }

  static Future<QuerySnapshot> getLotes() async {
    return await firebaseFirestore.collection('lotes').get();
  }

  static Future<QuerySnapshot> getSpotsByLote(String idLote) async {
    return await firebaseFirestore.collection('spots').where('lote', isEqualTo: idLote).get();
  }

  static Future<QuerySnapshot> getEntradaSaida(String idLote, String idSpot) async {
    return await FirebaseFirestore.instance
        .collection('entrada-Saida')
        .where('lote', isEqualTo: idLote)
        .where('spot', isEqualTo: idSpot)
        .get();
  }

  static updateSpotStatus(Spot spot) {
    firebaseFirestore.collection('spots').doc(spot.id).update(
      {
        'vagaPreenchida': spot.vagaPreenchida.value,
      },
    );
  }

  static registerEntrada(EntradaSaida entradaSaida, TipoOperacao tp) async {
    try {
      await firebaseFirestore.collection('entrada-Saida').add({
        'createdAt': entradaSaida.createdAt,
        'spot': entradaSaida.spot,
        'entry': entradaSaida.entry,
        'out': entradaSaida.out,
        'placa': entradaSaida.placa,
        'lote': entradaSaida.lote
      }).then((DocumentReference value) {
        firebaseFirestore.collection('entrada-Saida').doc(value.id).update({'id': value.id});
        entradaSaida.id = value.id;
      });
    } catch (e) {
      debugger();
      print(e);
    }
  }

  static registerSaida(EntradaSaida entradaSaida, TipoOperacao tp) async {
    try {
      await firebaseFirestore
          .collection('entrada-Saida')
          .doc(entradaSaida.id)
          .update({'out': entradaSaida.out, 'totalTime': entradaSaida.totalTime});
    } catch (e) {
      debugger();
      print(e);
    }
  }

  static Future<QuerySnapshot> searchEntradaSaida(DateTime search) async {
    return await firebaseFirestore
        .collection('entrada-Saida')
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(search))
        .get();
  }
}
