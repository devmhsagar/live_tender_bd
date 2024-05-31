import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_tender_bd/screen/tenderDetails.dart';

class TenderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tender List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tenders').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic>? data = document.data() as Map<String, dynamic>?; // Use nullable type annotation
              if (data == null) {
                // Handle null data
                return SizedBox(); // Or any other widget you prefer
              }
              // Use null-aware operators to access properties safely
              String title = data['tenderId'] ?? 'Unknown Title';
              String department = data['department'] ?? 'Unknown Department';
              String location = data['location'] ?? 'Unknown Department';
              String method = data['method'] ?? 'Unknown Department';
              return ListTile(
                title: Text(title),
                subtitle: Text(location),
                trailing: Column(
                  children: [
                    Text(department),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TenderDetailsScreen(data: data)),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
