import 'package:flutter/material.dart';
import '../../models/vip_options.dart'; // Import the VIP options data

class ShowVipOptions extends StatelessWidget {
  const ShowVipOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1D1D),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xffB9A588), //change your color here
        ),
        title: const Text(
          'VIP Options',
          style: TextStyle(color: Color(0xffB9A588)),
        ),
        backgroundColor: Color(0xff1D1D1D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 10.0, // Space between columns
            mainAxisSpacing: 10.0, // Space between rows
            childAspectRatio: 0.8, // Adjust to provide enough space
          ),
          itemCount: vipOptions.length,
          itemBuilder: (context, index) {
            final option = vipOptions[index];
            return Card(
              color: const Color.fromARGB(255, 102, 73, 31), // Background color
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Image.asset(
                        option['image'],
                        height: 50, // Adjust height if needed
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${option['exp']} XP',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffB9A588), // Text color
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Color(0xff1D1D1D),
                      )),
                      onPressed: () {
                        // Add the functionality for purchasing with diamonds
                      },
                      child: Text(
                        '${option['diamonds']} Diamonds',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xffB9A588), // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
