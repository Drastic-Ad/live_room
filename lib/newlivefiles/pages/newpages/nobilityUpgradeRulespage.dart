import 'package:flutter/material.dart';

class UpgradeHelpPage extends StatelessWidget {
  const UpgradeHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xffB9A588), //change your color here
        ),
        title: const Text(
          'Nobility Upgrade Rules',
          style: TextStyle(color: Color(0xffB9A588)),
        ),
        backgroundColor: const Color(0xff1D1D1D),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SAMPLE TEXT?',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            Text(
                'The benefits of a premium subscription: ① Remove the banner and interstitial ads;. ② 25 GB cloud storage;. ③ Viewing 30 days profile visitors history;.'),
          ],
        ),
      ),
    );
  }
}
