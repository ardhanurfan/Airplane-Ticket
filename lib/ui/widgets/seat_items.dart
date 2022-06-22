import 'package:airplane/cubit/seat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/used_seat_cubit.dart';
import '../../shared/theme.dart';

class SeatItems extends StatelessWidget {
  const SeatItems({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<SeatCubit>().isSelected(id);

    // Ambil dari databse list kursi yang sudah terpakai
    List usedSeats = context.watch<UsedSeatCubit>().state;

    bool isAvailable(String id) {
      if (!usedSeats.contains(id)) {
        return true;
      } else {
        return false;
      }
    }

    seatColor() {
      if (!isAvailable(id)) {
        return kSeatUnavailableColor;
      } else {
        if (isSelected) {
          return kPrimaryColor;
        } else {
          return kSeatAvailableColor;
        }
      }
    }

    seatBorder() {
      if (isAvailable(id)) {
        return kPrimaryColor;
      } else {
        return kSeatUnavailableColor;
      }
    }

    seatText() {
      if (!isAvailable(id)) {
        return '';
      } else {
        if (isSelected) {
          return 'YOU';
        } else {
          return '';
        }
      }
    }

    return GestureDetector(
      onTap: () {
        if (isAvailable(id)) {
          context.read<SeatCubit>().seatSelect(id);
        }
      },
      child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: seatColor(),
              border: Border.all(color: seatBorder(), width: 2)),
          child: Center(
              child: Text(
            seatText(),
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semibold),
          ))),
    );
  }
}
