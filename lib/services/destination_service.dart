import 'package:airplane/models/destination_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DestinationService {
  final Query<Map<String, dynamic>> _destinationsReference =
      FirebaseFirestore.instance.collection('destinations');

  Future<List<DestinationModel>> fetchDestinations() async {
    try {
      QuerySnapshot result =
          await _destinationsReference.orderBy('nameDestination').get();

      List<DestinationModel> destionations = result.docs.map(
        (e) {
          return DestinationModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();
      return destionations;
    } catch (e) {
      throw e;
    }
  }
}
