import 'package:flutter/material.dart';

class BuyDiamondsPage extends StatefulWidget {
  const BuyDiamondsPage(
      {super.key, required Null Function(dynamic newBalance) onDiamondsAdded});

  @override
  _BuyDiamondsPageState createState() => _BuyDiamondsPageState();
}

class _BuyDiamondsPageState extends State<BuyDiamondsPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buy Diamonds')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the number of diamonds you want to buy:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number of diamonds',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateDiamonds(context);
              },
              child: const Text('Purchase Diamonds'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateDiamonds(BuildContext context) {
    final String text = _controller.text;
    if (text.isNotEmpty) {
      final int diamondsToAdd = int.tryParse(text) ?? 0;
      if (diamondsToAdd > 0) {
        // Update the diamond balance
        // You might want to use a state management solution like Provider, Riverpod, etc. to update the balance
        // Here we are just showing a snackbar for simplicity

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$diamondsToAdd diamonds added to your balance!'),
          ),
        );

        // Clear the text field
        _controller.clear();

        // Ideally, you would also update the diamond balance in your app state here
        // For example, by using a state management solution or by calling a method to update the balance
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid number of diamonds.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the number of diamonds.'),
        ),
      );
    }
  }
}
