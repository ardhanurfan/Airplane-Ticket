import 'package:airplane/cubit/page_cubit.dart';
import 'package:airplane/ui/pages/home_page.dart';
import 'package:airplane/ui/pages/setting_page.dart';
import 'package:airplane/ui/pages/transaction_page.dart';
import 'package:airplane/ui/pages/wallet_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/transaction_cubit.dart';
import '../widgets/custom_bottom_navigation_items.dart';
import '../../shared/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int newPage) {
      switch (newPage) {
        case 0:
          {
            return const HomePage();
          }
        case 1:
          {
            context
                .read<TransactionCubit>()
                .fetchTransaction(FirebaseAuth.instance.currentUser!.uid);
            return const TransactionPage();
          }
        case 2:
          {
            return const WalletPage();
          }
        case 3:
          {
            return const SettingPage();
          }
        default:
          {
            return const HomePage();
          }
      }
    }

    // NavBar
    Widget customBottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          width: double.infinity,
          margin: EdgeInsets.only(
              bottom: 30, right: defaultMargin, left: defaultMargin),
          decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(defaultRadiusCard)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationItems(index: 0, imageUrl: 'assets/icon_home.png'),
              NavigationItems(index: 1, imageUrl: 'assets/icon_booked.png'),
              NavigationItems(index: 2, imageUrl: 'assets/icon_card.png'),
              NavigationItems(index: 3, imageUrl: 'assets/icon_settings.png')
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, newPage) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              buildContent(newPage),
              customBottomNavigation(),
            ],
          ),
        );
      },
    );
  }
}
