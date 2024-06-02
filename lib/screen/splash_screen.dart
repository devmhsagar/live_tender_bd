import 'package:flutter/material.dart';
import 'package:live_tender_bd/screen/homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to TenderListScreen after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TenderListScreen()),
      );
    });

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/splash_logo.png', width: 120),
                  const SizedBox(height: 10),
                  const Text(
                    'livetenderbd.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Developed By AmazeSoft Solutions',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
