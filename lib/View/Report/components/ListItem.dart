import 'package:flutter/material.dart';
import 'package:park_do_jao/Models/EntradaSaida.dart';
import 'package:park_do_jao/View/Park/components/SelectedSpot.dart';

class ListItem extends StatelessWidget {
  const ListItem(this.entradaSaida, {Key? key}) : super(key: key);
  final EntradaSaida entradaSaida;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 4),
        // tileColor: Color(0xffDBDFFD),
        leading: SelectedSpot(
          vaga: int.parse(entradaSaida.spotNumber),
          lote: entradaSaida.loteName,
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: const Text(
              "AHZ7J88",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text("Entrada: ${entradaSaida.entry}"),
            Text("Saída: ${entradaSaida.out ?? ""}")
          ])
        ]),
        trailing: Padding(
          padding: EdgeInsets.all(4),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              "Tempo total",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text((entradaSaida.totalTime ?? "").toString()),
          ]),
        ),
      ),
    );
  }
}
