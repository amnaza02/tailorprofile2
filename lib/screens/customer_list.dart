import 'package:flutter/material.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followers"),
        backgroundColor: Color.fromARGB(255, 178, 143, 119),
        foregroundColor: Color.fromARGB(255, 245, 237, 226),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.people, size: 50, color: Color.fromARGB(255, 178, 143, 119)),
            SizedBox(height: 20),
            Text(
              "List of followers will be shown here.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            // You can add actual Firebase data loading and display here later
          ],
        ),
      ),
    );
  }
}
