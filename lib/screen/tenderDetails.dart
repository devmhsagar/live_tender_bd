import 'package:flutter/material.dart';
import 'package:live_tender_bd/database/services_model.dart'; // Importing the Tender class

class TenderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> tender;
  TenderDetailScreen({Key? key, required this.tender}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Tender Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tender ID-${tender['tenderId']}',
                        style: const TextStyle(color: Colors.white)),
                    Text(tender['method'],
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('Name of Work: ${tender['nameOfWork']}'),
              const SizedBox(height: 8),
              Text('Department: ${tender['department']}'),
              const SizedBox(height: 8),
              Text('Location: ${tender['location']}'),
              const SizedBox(height: 8),
              Text('LastDate: ${tender['tenderLastDate']}'),
              const SizedBox(height: 8),
              Text('Doc Price: ${tender['docPrice']}'),
              const SizedBox(height: 8),
              Text('Tender Security: ${tender['tenderSecurity']}'),
              const SizedBox(height: 8),
              Text('Liquid: ${tender['liquid']}'),
              const SizedBox(height: 8),
              Text('Similar: ${tender['similar']}'),
              const SizedBox(height: 8),
              Text('Turnover: ${tender['turnover']}'),
              const SizedBox(height: 8),
              Text('Tender Capacity: ${tender['tenderCapacity']}'),
              const SizedBox(height: 8),
              Text('Others: ${tender['others']}'),
              const SizedBox(height: 16),
              Text('Tender LastDate: ${tender['tenderLastDate']}'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
