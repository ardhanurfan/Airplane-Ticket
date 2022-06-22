import 'package:airplane/cubit/page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';

class NavigationItems extends StatelessWidget {
  const NavigationItems({Key? key, required this.imageUrl, required this.index})
      : super(key: key);

  final String imageUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Image.asset(imageUrl,
              color: (context.read<PageCubit>().state == index)
                  ? kPrimaryColor
                  : kGreyColor,
              height: 24,
              width: 24),
          Container(
            height: 2,
            width: 30,
            decoration: BoxDecoration(
                color: (context.read<PageCubit>().state == index)
                    ? kPrimaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18)),
          )
        ],
      ),
    );
  }
}
