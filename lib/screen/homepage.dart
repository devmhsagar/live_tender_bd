import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_tender_bd/database/services.dart';
import 'package:live_tender_bd/screen/tenderDetails.dart';



class TenderListScreen extends StatefulWidget {
  @override
  _TenderListScreenState createState() => _TenderListScreenState();
}

class _TenderListScreenState extends State<TenderListScreen> {
  DatabaseMethods _databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 8),
            const Text('Live Tender BD'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 0),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _databaseMethods.getTenderDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No tenders available'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var tender = snapshot.data!.docs[index].data();
                      return TenderCard(tender: tender as Map<String, dynamic>);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TenderCard extends StatelessWidget {
  final Map<String, dynamic> tender;

   TenderCard({Key? key, required this.tender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name of Work: ${tender['nameOfWork']}'),
                const SizedBox(height: 8),
                Text('Department: ${tender['department']}'),
                const SizedBox(height: 8),
                Text('Location: ${tender['location']}'),
                const SizedBox(height: 8),
                Text('Last Date: ${tender['tenderLastDate']}'),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TenderDetailScreen(tender: tender),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Click Details',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}


