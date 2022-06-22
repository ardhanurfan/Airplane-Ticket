import 'package:airplane/cubit/seat_cubit.dart';
import 'package:airplane/cubit/used_seat_cubit.dart';
import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/ui/pages/checkout_page.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/destination_model.dart';
import '../../shared/theme.dart';
import '../widgets/seat_item_text.dart';
import '../widgets/seat_rows.dart';

class ChooseSeatPage extends StatefulWidget {
  const ChooseSeatPage(this.destination, {Key? key}) : super(key: key);

  final DestinationModel destination;

  @override
  State<ChooseSeatPage> createState() => _ChooseSeatPageState();
}

class _ChooseSeatPageState extends State<ChooseSeatPage> {
  @override
  void initState() {
    context.read<SeatCubit>().initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        child: Text(
          'Select Your\nFavorite Seat',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
        ),
      );
    }

    Widget indicatorSeat() {
      return Row(
        children: [
          Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.only(right: 6),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon_available.png')))),
          Text('Available', style: blackTextStyle),
          const SizedBox(width: 10),
          Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.only(right: 6),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon_selected.png')))),
          Text('Selected', style: blackTextStyle),
          const SizedBox(width: 10),
          Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.only(right: 6),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon_unavailable.png')))),
          Text('Unavailable', style: blackTextStyle),
        ],
      );
    }

    Widget content() {
      return BlocBuilder<SeatCubit, List>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(defaultRadiusCard)),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SeatItemText(text: 'A'),
                      SeatItemText(
                        text: 'B',
                      ),
                      SeatItemText(),
                      SeatItemText(text: 'C'),
                      SeatItemText(text: 'D'),
                    ],
                  ),
                ),
                const SeatRows(
                  rowNumber: 1,
                ),
                const SeatRows(
                  rowNumber: 2,
                ),
                const SeatRows(
                  rowNumber: 3,
                ),
                const SeatRows(
                  rowNumber: 4,
                ),
                const SeatRows(
                  rowNumber: 5,
                ),

                // YOUR SEAT
                const SizedBox(height: 14),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your seat',
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light)),
                    Expanded(
                      child: Text(state.join(', '),
                          textAlign: TextAlign.end,
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium)),
                    )
                  ],
                ),

                // PRICE
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price',
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light)),
                    Text(
                        NumberFormat.currency(
                          locale: 'id',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(state.length * widget.destination.price),
                        style: purpleTextStyle.copyWith(
                            fontSize: 16, fontWeight: semibold))
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              children: [
            title(),
            indicatorSeat(),
            content(),
            BlocBuilder<SeatCubit, List>(
              builder: (context, state) {
                return CustomButton(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 46),
                    text: 'Continue to Checkout',
                    onPressed: () {
                      if (state.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: kRedColor,
                          duration: Duration(seconds: 2),
                          content: Text(
                            'Choose Your Seat Before Checkout',
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else {
                        // Check Update Ketersediaan
                        context
                            .read<UsedSeatCubit>()
                            .fetchUsedSeats(widget.destination);

                        List usedSeats = context.read<UsedSeatCubit>().state;

                        //jika tidak ada yang beririsan maka TRUE
                        isAvailable() {
                          if (state
                              .toSet()
                              .intersection(usedSeats.toSet())
                              .isEmpty) {
                            return true;
                          } else {
                            return false;
                          }
                        }

                        if (isAvailable()) {
                          int price = widget.destination.price * state.length;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOutPage(
                                    TransactionModel(
                                        createdAt:
                                            Timestamp.fromDate(DateTime.now()),
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        destination: widget.destination,
                                        amountOfTraveler: state.length,
                                        selectedSeat: state.join(', '),
                                        insurance: true,
                                        refundable: false,
                                        vat: 0.45,
                                        price: price,
                                        grandTotal:
                                            price + (price * 0.45).toInt())),
                              ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: kRedColor,
                            duration: Duration(seconds: 2),
                            content: Text(
                              'Seats Are No Longer Available',
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }
                      }
                    });
              },
            )
          ])),
    );
  }
}
