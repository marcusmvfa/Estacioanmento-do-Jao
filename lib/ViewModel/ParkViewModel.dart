import 'package:get/get.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/Models/Spot.dart';

enum TipoOperacao {
  entrada,
  saida,
}

class ParkViewModel extends GetxController {
  List<Lote> lotes = [Lote("A", 0), Lote("B", 1), Lote("C", 2), Lote("D", 3)];
  var operacaoSelecionada = TipoOperacao.entrada.obs;
  var vaga = 0.obs;
  var vagaSelecionada = Spot("", 0).obs;

  updateFreeSpots(Lote lote) {
    var vagasPreenchidas = [];
    lote.spots.forEach((element) {
      if (element.vagaPreenchida.value) vagasPreenchidas.add(element);
    });
    lote.freeSpots.value = lote.spots.length - vagasPreenchidas.length;
  }

  ///Lote A = 0
  ///Lote B = 1
  ///Lote C = 2
  ///Lote D = 3
  var lote = [].obs;
}
