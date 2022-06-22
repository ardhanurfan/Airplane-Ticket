import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BonusPage extends StatelessWidget {
  const BonusPage({Key? key}) : super(key: key);

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
                          Text('IDR 280.000.000',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 26, fontWeight: medium))
                        ]),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cardWidget(),
            Text('Big Bonus 🎉',
                style: blackTextStyle.copyWith(
                    fontSize: 32, fontWeight: semibold)),
            const SizedBox(height: 10),
            Text(
                'We give you early credit so that\nyou can buy a flight ticket',
                style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
                textAlign: TextAlign.center),
            CustomButton(
              width: 220,
              margin: const EdgeInsets.only(top: 50),
              text: 'Start Fly Now',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/main', (route) => false),
            )
          ],
        ),
      ),
    );
  }
}
