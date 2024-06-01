import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTender(Map<String, dynamic> addTenderMap, String id) async {
    try {
      await _firestore.collection("tenders").doc(id).set(addTenderMap);
    } catch (e) {
      print('Error adding tender: $e');
    }
  }

  Stream<QuerySnapshot> getTenderDetails() {
    return FirebaseFirestore.instance.collection("tenders").snapshots();
  }
}
