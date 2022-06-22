import 'package:bloc/bloc.dart';

class SeatCubit extends Cubit<List> {
  SeatCubit() : super([]);

  void initState() {
    emit([]);
  }

  void seatSelect(String id) {
    if (!isSelected(id)) {
      state.add(id);
    } else {
      state.remove(id);
    }
    // print(state);
    emit(List.from(state));
  }

  bool isSelected(String id) {
    if (state.contains(id)) {
      return true;
    } else {
      return false;
    }
  }
}
