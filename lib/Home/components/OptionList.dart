import 'package:flutter/material.dart';
import 'package:park_do_jao/Home/components/OptionCard.dart';

class OptionList extends StatelessWidget {
  const OptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: const [
        OptionCard(),
        OptionCard(),
        OptionCard(),
      ]),
    );
  }
}
