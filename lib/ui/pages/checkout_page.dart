import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/services/user_service.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:airplane/ui/widgets/detail_items.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/used_seat_cubit.dart';

class CheckOutPage extends StatelessWidget {
  final TransactionModel transaction;

  const CheckOutPage(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ROUTE
    Widget route() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              height: 65,
              width: 291,
              margin: const EdgeInsets.only(bottom: 10),
              child:
                  Image.asset('assets/image_checkout.png', fit: BoxFit.cover),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CGK',
                        style: blackTextStyle.copyWith(
                            fontSize: 24, fontWeight: semibold)),
                    Text('Tangerang',
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        (transaction.destination.nameDestination[0] +
                                transaction.destination.nameDestination[
                                    (transaction.destination.nameDestination
                                                .length /
                                            2)
                                        .round()] +
                                transaction.destination.nameDestination[
                                    transaction.destination.nameDestination
                                            .length -
                                        1])
                            .toUpperCase(),
                        style: blackTextStyle.copyWith(
                            fontSize: 24, fontWeight: semibold)),
                    Text(transaction.destination.city,
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light))
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    // BOOKING DETAILS
    Widget bookingDetails() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadiusCard)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination Title
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      transaction.destination.imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.circular(defaultRadiusCard))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.destination.nameDestination,
                            style: blackTextStyle.copyWith(
                                fontSize: 18, fontWeight: medium),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(transaction.destination.city,
                              style: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: light))
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/icon_star.png')))),
                    Text(transaction.destination.rating.toString(),
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium))
                  ],
                ),
              ],
            ),

            // Items Detail
            const SizedBox(height: 20),
            Text('Booking Details',
                style: blackTextStyle.copyWith(
                    fontSize: 16, fontWeight: semibold)),
            DetailItems(
                title: 'Traveler',
                value: '${transaction.amountOfTraveler} person',
                marginTop: 10),
            DetailItems(
                title: 'Seat',
                value: '${transaction.selectedSeat}',
                marginTop: 16),
            DetailItems(
                title: 'Insurance',
                value: transaction.insurance ? 'YES' : 'NO',
                marginTop: 16),
            DetailItems(
                title: 'Refundable',
                value: transaction.refundable ? 'YES' : 'NO',
                marginTop: 16),
            DetailItems(
                title: 'VAT',
                value: '${(transaction.vat * 100).toInt()}%',
                marginTop: 16),
            DetailItems(
                title: 'Price',
                value: NumberFormat.currency(
                  locale: 'id',
                  decimalDigits: 0,
                  symbol: 'IDR ',
                ).format(transaction.price),
                marginTop: 16),
            DetailItems(
                title: 'Grand Total',
                value: NumberFormat.currency(
                  locale: 'id',
                  decimalDigits: 0,
                  symbol: 'IDR ',
                ).format(transaction.grandTotal),
                marginTop: 16),
          ],
        ),
      );
    }

    // PAYMENT DETAILS
    Widget paymentDetails(int userBalance) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadiusCard)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Details',
                style: blackTextStyle.copyWith(
                    fontSize: 16, fontWeight: semibold)),
            const SizedBox(height: 16),
            Row(
              children: [
                // CARD
                Container(
                    margin: const EdgeInsets.only(right: 16),
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/image_card.png')),
                        boxShadow: [
                          BoxShadow(
                              color: kPrimaryColor.withOpacity(0.6),
                              blurRadius: 30,
                              offset: const Offset(0, 10))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 24,
                            width: 24,
                            margin: const EdgeInsets.only(right: 6),
                            child: Image.asset('assets/icon_logo.png')),
                        Text('Pay',
                            style: whiteTextStyle.copyWith(
                                fontSize: 16, fontWeight: medium))
                      ],
                    )),

                // PRICE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        NumberFormat.currency(
                          locale: 'id',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(userBalance),
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: medium)),
                    const SizedBox(height: 5),
                    Text('Current Balance',
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light))
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    // PAY NOW BUTTON
    Widget payNow(int userBalance) {
      return BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/success', (route) => false);
          } else if (state is TransactionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: kRedColor,
              content: Text(state.error),
            ));
          }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }
          return CustomButton(
            width: double.infinity,
            text: 'Pay Now',
            margin: const EdgeInsets.only(top: 30, bottom: 30),
            onPressed: () {
              if (userBalance >= transaction.grandTotal) {
                // Check Update Ketersediaan
                context
                    .read<UsedSeatCubit>()
                    .fetchUsedSeats(transaction.destination);

                List usedSeats = context.read<UsedSeatCubit>().state;

                //jika tidak ada yang beririsan maka TRUE
                isAvailable() {
                  if (transaction.selectedSeat
                      .split(', ')
                      .toSet()
                      .intersection(usedSeats.toSet())
                      .isEmpty) {
                    return true;
                  } else {
                    return false;
                  }
                }

                if (isAvailable()) {
                  context
                      .read<TransactionCubit>()
                      .createTransaction(transaction);
                  UserService()
                      .updateBalance(userBalance - transaction.grandTotal);
                  context
                      .read<AuthCubit>()
                      .getCurrentUser(FirebaseAuth.instance.currentUser!.uid);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: kRedColor,
                    duration: Duration(seconds: 2),
                    content: Text(
                      'Seats Are No Longer Available',
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: kRedColor,
                  duration: Duration(seconds: 2),
                  content: Text(
                    'Please Top Up Your Balance',
                    textAlign: TextAlign.center,
                  ),
                ));
              }
            },
          );
        },
      );
    }

    // TAC BUTTON
    Widget tacButton() {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 30),
        child: Text(
          'Terms and Conditions',
          style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline),
        ),
      );
    }

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Scaffold(
            backgroundColor: kBackgroundColor,
            body: SafeArea(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              children: [
                route(),
                bookingDetails(),
                paymentDetails(state.user.balance),
                payNow(state.user.balance),
                tacButton()
              ],
            )),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
