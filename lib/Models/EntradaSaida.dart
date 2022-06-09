import 'package:cloud_firestore/cloud_firestore.dart';

class EntradaSaida {
  String spot = "";
  String id = "";
  String entry = "";
  String? out;
  String placa = "";
  String lote = "";
  String? totalTime;
  DateTime createdAt = DateTime.now();

  EntradaSaida(this.spot, this.entry, this.placa, this.lote, {this.out, this.totalTime});

  EntradaSaida.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spot = json['spot'];
    lote = json['lote'];
    placa = json['placa'];
    entry = json['entry'];
    out = json['out'];
    totalTime = json['totalTime'];
    createdAt = (json['createdAt'] as Timestamp).toDate();
  }

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['spot'] = spot;
    data['lote'] = lote;
    data['placa'] = placa;
    data['entry'] = entry;
    data['createdAt'] = createdAt;
    if (out != null) {
      data['out'] = out;
    }
    if (totalTime != null) {
      data['totalTime'] = totalTime;
    }

    return data;
  }
}
