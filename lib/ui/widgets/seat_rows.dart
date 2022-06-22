import 'package:flutter/material.dart';

import 'seat_item_text.dart';
import 'seat_items.dart';

class SeatRows extends StatelessWidget {
  const SeatRows({
    Key? key,
    required this.rowNumber,
  }) : super(key: key);

  final int rowNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SeatItems(id: 'A$rowNumber'),
          SeatItems(id: 'B$rowNumber'),
          SeatItemText(text: rowNumber.toString()),
          SeatItems(id: 'C$rowNumber'),
          SeatItems(id: 'D$rowNumber'),
        ],
      ),
    );
  }
}
