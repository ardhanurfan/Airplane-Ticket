import 'package:airplane/models/destination_model.dart';
import 'package:airplane/services/used_seat_service.dart';
import 'package:bloc/bloc.dart';

class UsedSeatCubit extends Cubit<List> {
  UsedSeatCubit() : super([]);

  void fetchUsedSeats(DestinationModel destination) async {
    List usedSeats = await UsedSeatService().fetchUsedSeats(destination);
    emit(List.from(usedSeats));
  }
}
