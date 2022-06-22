import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/destination_cubit.dart';
import '../../cubit/page_cubit.dart';
import '../../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;

    Timer(
      const Duration(seconds: 3),
      () {
        context.read<DestinationCubit>().fetchDestinations();
        if (user != null) {
          context.read<AuthCubit>().getCurrentUser(user.uid);
          context.read<PageCubit>().setPage(0);
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/get-started', (route) => false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon_logo.png')))),
          const SizedBox(
            height: 50,
          ),
          Text(
            "AIRPLANE",
            style: whiteTextStyle.copyWith(
                fontSize: 32, fontWeight: medium, letterSpacing: 10),
          )
        ],
      )),
    );
  }
}
