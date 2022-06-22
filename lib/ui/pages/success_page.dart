import 'package:airplane/cubit/page_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/transaction_cubit.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardWidget() {
      return Container(
        margin: const EdgeInsets.only(bottom: 80),
        height: 150,
        width: 300,
        child: Image.asset('assets/image_booked.png'),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cardWidget(),
            Text('Well Booked 😍',
                style: blackTextStyle.copyWith(
                    fontSize: 32, fontWeight: semibold)),
            const SizedBox(height: 10),
            Text('Are you ready to explore the new\nworld of experiences?',
                style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
                textAlign: TextAlign.center),
            CustomButton(
                width: 220,
                margin: const EdgeInsets.only(top: 50),
                text: 'My Bookings',
                onPressed: () {
                  context
                      .read<TransactionCubit>()
                      .fetchTransaction(FirebaseAuth.instance.currentUser!.uid);
                  context.read<PageCubit>().setPage(1);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/main', (route) => false);
                })
          ],
        ),
      ),
    );
  }
}
