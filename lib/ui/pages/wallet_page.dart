import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardWidget() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: const EdgeInsets.only(bottom: 80),
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/image_card.png')),
                  boxShadow: [
                    BoxShadow(
                        color: kPrimaryColor.withOpacity(0.7),
                        blurRadius: 50,
                        offset: const Offset(0, 10))
                  ]),
              child: Container(
                padding: EdgeInsets.all(defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name',
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 14, fontWeight: light)),
                                Text(state.user.name,
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 20, fontWeight: medium),
                                    overflow: TextOverflow.ellipsis)
                              ]),
                        ),
                        Row(children: [
                          Container(
                            margin: const EdgeInsets.only(right: 6),
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/icon_logo.png'))),
                          ),
                          Text('Pay',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 16, fontWeight: medium))
                        ])
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Balance',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 14, fontWeight: light)),
                          Text(
                              NumberFormat.currency(
                                locale: 'id',
                                decimalDigits: 0,
                                symbol: 'IDR ',
                              ).format(state.user.balance),
                              style: whiteTextStyle.copyWith(
                                  fontSize: 26, fontWeight: medium))
                        ]),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: cardWidget(),
      ),
    );
  }
}
