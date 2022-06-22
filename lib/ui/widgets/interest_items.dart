import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class InterestItems extends StatelessWidget {
  const InterestItems({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          Text(text, style: blackTextStyle)
        ],
      ),
    );
  }
}
