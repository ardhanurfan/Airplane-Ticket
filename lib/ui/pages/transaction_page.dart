import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        } else if (state is TransactionSuccess) {
          if (state.transactions.isEmpty) {
            return Center(
              child: Text(
                'Kamu Belum Memiliki Transaksi',
                style:
                    greyTextStyle.copyWith(fontSize: 16, fontWeight: semibold),
              ),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(
                  right: defaultMargin,
                  left: defaultMargin,
                  bottom: 140,
                  top: 50),
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return TransactionCard(state.transactions[index]);
              },
            );
          }
        }
        return const Center(child: Text('FOUND SOME ERRORS!'));
      },
    );
  }
}
