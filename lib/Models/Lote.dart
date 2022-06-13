import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:park_do_jao/Models/Spot.dart';

class Lote {
  String id = "";
  String name = "";
  var index = 0;
  var freeSpots = 10.obs;

  late Stream<QuerySnapshot> streamSpots;

  ///Vagas
  var spots = <Spot>[].obs;

  Lote(this.name, this.index) {
    for (int i = 0; i < 10; i++) {
      spots.add(Spot(name, i));
    }
  }
  Lote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['spots'] != null) {
      spots.value = <Spot>[];
      json['spots'].forEach((v) {
        spots.add(Spot.fromJson(v));
      });
    }
  }
}
