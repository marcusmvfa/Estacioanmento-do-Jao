import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';

class Spot {
  // Lote lote;
  String lot;
  int id;
  var vagaPreenchida = false.obs;
  Spot(this.lot, this.id);
}
