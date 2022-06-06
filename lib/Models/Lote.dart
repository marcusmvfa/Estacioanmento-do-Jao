import 'package:get/get.dart';
import 'package:park_do_jao/Models/Spot.dart';

class Lote {
  String id = "";
  var index = 0;
  var freeSpots = 10.obs;

  ///Vagas
  List<Spot> spots = [];
  Lote(this.id, this.index) {
    for (int i = 0; i < 10; i++) {
      spots.add(Spot(id, i));
    }
  }
}
