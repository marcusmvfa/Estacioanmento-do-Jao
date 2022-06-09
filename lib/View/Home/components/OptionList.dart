import 'package:flutter/material.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/View/Home/components/OptionCard.dart';

class OptionList extends StatelessWidget {
  const OptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        OptionCard(TipoOperacao.entrada),
        OptionCard(TipoOperacao.saida),
        OptionCard(TipoOperacao.relatorio),
      ]),
    );
  }
}
