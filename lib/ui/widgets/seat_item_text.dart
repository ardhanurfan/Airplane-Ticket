import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class SeatItemText extends StatelessWidget {
  const SeatItemText({Key? key, this.text = ''}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 48,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          text,
          style: greyTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        )));
  }
}
