import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class DetailItems extends StatelessWidget {
  const DetailItems(
      {Key? key,
      required this.title,
      required this.value,
      required this.marginTop})
      : super(key: key);

  final String title;
  final String value;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    colorCheck() {
      if (title == 'Insurance' || title == 'Refundable') {
        switch (value) {
          case 'YES':
            {
              return greenTextStyle.copyWith(
                  fontSize: 14, fontWeight: semibold);
            }
          case 'NO':
            {
              return redTextStyle.copyWith(fontSize: 14, fontWeight: semibold);
            }
          default:
            {
              return blackTextStyle.copyWith(
                  fontSize: 14, fontWeight: semibold);
            }
        }
      } else if (title == 'Grand Total') {
        return purpleTextStyle.copyWith(fontSize: 14, fontWeight: semibold);
      } else {
        return blackTextStyle.copyWith(fontSize: 14, fontWeight: semibold);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icon_checklist.png'),
                            fit: BoxFit.cover))),
                const SizedBox(width: 6),
                Text(title, style: blackTextStyle)
              ],
            ),
          ),
          Text(
            value,
            style: colorCheck(),
          )
        ],
      ),
    );
  }
}
