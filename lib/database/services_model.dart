import 'package:cloud_firestore/cloud_firestore.dart';

class Tender {
  final String id;
  final String method;
  final String tenderId;
  final String nameOfWork;
  final String department;
  final String location;
  final String lastDate;
  final String docPrice;
  final String tenderSecurity;
  final String liquid;
  final String similar;
  final String turnover;
  final String tenderCapacity;
  final String others;
  final String tenderLastDate;

  Tender({
    required this.id,
    required this.method,
    required this.nameOfWork,
    required this.tenderId,
    required this.department,
    required this.location,
    required this.lastDate,
    required this.docPrice,
    required this.tenderSecurity,
    required this.liquid,
    required this.similar,
    required this.turnover,
    required this.tenderCapacity,
    required this.others,
    required this.tenderLastDate,
  });

  factory Tender.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Tender(
      id: doc.id,
      method: data['method'] ?? '',
      nameOfWork: data['nameOfWork'] ?? '',
      tenderId: data['tenderId'] ?? '',
      department: data['department'] ?? '',
      location: data['location'] ?? '',
      lastDate: data['lastDate'] ?? '',
      docPrice: data['docPrice'] ?? 0,
      tenderSecurity: data['tenderSecurity'] ?? 0,
      liquid: data['liquid'] ?? 0,
      similar: data['similar'] ?? 0,
      turnover: data['turnover'] ?? 0,
      tenderCapacity: data['tenderCapacity'] ?? 0,
      others: data['others'] ?? '',
      tenderLastDate: data['tenderLastDate'] ?? '',
    );
  }
}
