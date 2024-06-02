import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_tender_bd/database/services.dart';
import 'package:live_tender_bd/screen/tenderDetails.dart';

class TenderListScreen extends StatefulWidget {
  const TenderListScreen({super.key});

  @override
  _TenderListScreenState createState() => _TenderListScreenState();
}

class _TenderListScreenState extends State<TenderListScreen> {
  final DatabaseMethods _databaseMethods = DatabaseMethods();
  String searchQuery = '';
  String filterMethod = '';
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  List<String> tenderMethods = ['LTM', 'OTM', 'OSTETM', 'RFQ', 'RFQU'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              height: 35,
              width: 35,
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
      body: GestureDetector(
        onTap: () {
          searchFocusNode.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: searchFocusNode,
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
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
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.filter_list),
                    onSelected: (value) {
                      setState(() {
                        if (value == 'Reset Filter') {
                          filterMethod = '';
                          searchQuery = '';
                          searchController.clear();
                        } else {
                          filterMethod = value;
                        }
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        ...tenderMethods.map((String method) {
                          return PopupMenuItem<String>(
                            value: method,
                            child: Text(method),
                          );
                        }).toList(),
                        const PopupMenuItem<String>(
                          value: 'Reset Filter',
                          child: Text('ALL'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _databaseMethods.getTenderDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No tenders available'));
                    }

                    var tenders = snapshot.data!.docs.map((doc) {
                      return doc.data() as Map<String, dynamic>;
                    }).toList();

                    // Filter and search tenders
                    tenders = tenders.where((tender) {
                      final tenderId =
                          tender['tenderId'].toString().toLowerCase();
                      final method = tender['method'].toString().toLowerCase();
                      final department =
                          tender['department'].toString().toLowerCase();
                      final location =
                          tender['location'].toString().toLowerCase();
                      final lastDate =
                          tender['tenderLastDate'].toString().toLowerCase();

                      final matchesSearch = searchQuery.isEmpty ||
                          tenderId.contains(searchQuery) ||
                          method.contains(searchQuery) ||
                          department.contains(searchQuery) ||
                          location.contains(searchQuery) ||
                          lastDate.contains(searchQuery);

                      final matchesFilter = filterMethod.isEmpty ||
                          method == filterMethod.toLowerCase();

                      return matchesSearch && matchesFilter;
                    }).toList();

                    // Sort tenders by last date
                    tenders.sort((a, b) {
                      final dateA = DateTime.parse(a['tenderLastDate']);
                      final dateB = DateTime.parse(b['tenderLastDate']);
                      return dateA.compareTo(dateB);
                    });

                    return ListView.builder(
                      itemCount: tenders.length,
                      itemBuilder: (context, index) {
                        var tender = tenders[index];
                        return TenderCard(tender: tender);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TenderCard extends StatelessWidget {
  final Map<String, dynamic> tender;

  const TenderCard({super.key, required this.tender});

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
