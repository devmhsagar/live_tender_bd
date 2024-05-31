import 'package:flutter/material.dart';

class TenderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const TenderDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['tenderTitle']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Department: ${data['department']}'),
            Text('Location: ${data['location']}'),
            Text('Last Date: ${data['lastDate']}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
