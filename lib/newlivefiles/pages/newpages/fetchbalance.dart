import 'package:flutter/material.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  _ApiCallState createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  int diamondBalance = 100;

  @override
  void initState() {
    super.initState();
    fetchDiamondBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diamond Balance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Current Balance: $diamondBalance diamonds',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Future<void> fetchDiamondBalance() async {
    // Simulate fetching balance from an API or database
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    setState(() {
      diamondBalance = 100; // Replace with the fetched balance
    });
  }
}
