import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';

class Spot {
  // Lote lote;
  String id = "";
  int number = -1;
  String lot = "";
  String placa = "";
  String? horaEntrada;
  String? horaSaida;
  var vagaPreenchida = false.obs;

  Spot(this.lot, this.number);

  Spot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    lot = json['lote'];
    placa = json['placa'];
    vagaPreenchida.value = json['vagaPreenchida'] ?? false;
  }

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['lot'] = lot;
    data['placa'] = placa;
    data['vagaPreenchida'] = vagaPreenchida.value;

    if (horaEntrada != null) {
      data['horaEntrada'] = horaEntrada;
    }
    if (horaSaida != null) {
      data['horaSaida'] = horaSaida;
    }
    return data;
  }
}
