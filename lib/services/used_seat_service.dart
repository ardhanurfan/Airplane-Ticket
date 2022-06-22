import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/destination_model.dart';

class UsedSeatService {
  final CollectionReference _transactionReference =
      FirebaseFirestore.instance.collection('transactions');

  Future<List> fetchUsedSeats(DestinationModel destination) async {
    QuerySnapshot result = await _transactionReference
        .where('destination', isEqualTo: destination.toJson())
        .get();

    List usedSeats = [];

    result.docs.forEach((element) {
      usedSeats += element['selectedSeat'].split(', ');
    });

    return usedSeats;
  }
}
