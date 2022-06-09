import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_do_jao/Constants/Enums.dart';

class SpotFilledDialog extends StatelessWidget {
  const SpotFilledDialog(this.entrada, {Key? key}) : super(key: key);
  final entrada;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ops!"),
      content: Container(
        child: entrada == TipoOperacao.entrada
            ? const Text("Esta vaga já está preenchida!\nPor favor, selecione outra!")
            : const Text("Esta vaga está vazia!\nPor favor, selecione outra!"),
      ),
      actions: [
        ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Ok"))
      ],
    );
  }
}
