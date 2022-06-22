import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/ui/widgets/detail_items.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(this.transaction, {Key? key}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
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
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semibold)),
          DetailItems(
              title: 'Traveler',
              value: '${transaction.amountOfTraveler} person',
              marginTop: 10),
          DetailItems(
              title: 'Seat', value: '$transaction.selectedSeat', marginTop: 16),
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
}
