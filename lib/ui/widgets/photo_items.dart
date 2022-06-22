import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class PhotoItems extends StatelessWidget {
  const PhotoItems({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageUrl)),
          borderRadius: BorderRadius.circular(defaultRadiusCard)),
    );
  }
}
