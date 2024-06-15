import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  Future<void> addTender(Map<String, dynamic> addTenderMap, String id) async {
    try {
      await _firestore.collection("tenders").doc(id).set(addTenderMap);
    } catch (e) {
      _logger.e('Error adding tender: $e');
    }
  }

  Stream<QuerySnapshot> getTenderDetails() {
    return _firestore.collection("tenders").snapshots();
  }
}
