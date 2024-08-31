import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/pages/newpages/buydiamond.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/pages/newpages/vipPage.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/pages/xpProgressBar.dart';
import 'giftTile.dart'; // Import the new GiftTile class

class ShowGift extends StatefulWidget {
  final Future<void> Function() onSendGift;

  const ShowGift({super.key, required this.onSendGift});

  @override
  State<ShowGift> createState() => _ShowGiftState();
}

class _ShowGiftState extends State<ShowGift> {
  int selectedContainer = 0;
  int userXP = 0; // Current XP
  int potentialXP = 0; // Potential XP based on the selected gift
  int diamondBalance = 0; // Diamond balance initialized to 0

  List<String> ranks = [
    'Iron',
    'Bronze',
    'Silver',
    'Gold',
    'Platinum',
    'Diamond',
    'Immortal',
    'Radiant'
  ];

  // Cost of each gift in terms of diamonds
  List<int> giftCosts = [1, 5, 10];

  @override
  void initState() {
    super.initState();
    fetchDiamondBalance(); // Fetch diamond balance when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff0E0E0E),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Rank text above the progress bar
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VIPPage()));
              },
              child: Column(
                children: [
                  Text(
                    'Rank: ${ranks[(userXP / 1000).floor() % ranks.length]}',
                    style: const TextStyle(
                      color: const Color(0xffB9A588),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Use the XPProgressBar widget
                  XPProgressBar(
                    width: 300,
                    userXP: userXP,
                    potentialXP: potentialXP,
                    ranks: ranks,
                  ),
                ],
              ),
            ),
            // Diamonds balance and + button in the top right corner
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Diamonds: $diamondBalance',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffB9A588),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xffB9A588),
                  ),
                  onPressed: () {
                    // Navigate to Buy Diamonds page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuyDiamondsPage(
                          onDiamondsAdded: (newBalance) {
                            setState(() {
                              diamondBalance = newBalance;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                    width: 20), // Space between the button and the edge
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GiftTile(
                    index: 0,
                    icon: Icons.diamond,
                    color: const Color(0xffB9A588),
                    count: '1',
                    xp: 100,
                    selectedContainer: selectedContainer,
                    onSelect: (index) {
                      setState(() {
                        selectedContainer = index;
                        potentialXP = 100;
                      });
                    },
                  ),
                  GiftTile(
                    index: 1,
                    icon: Icons.diamond,
                    color: const Color(0xffB9A588),
                    count: '5',
                    xp: 500,
                    selectedContainer: selectedContainer,
                    onSelect: (index) {
                      setState(() {
                        selectedContainer = index;
                        potentialXP = 500;
                      });
                    },
                  ),
                  GiftTile(
                    index: 2,
                    icon: Icons.diamond,
                    color: const Color(0xffB9A588),
                    count: '10',
                    xp: 1000,
                    selectedContainer: selectedContainer,
                    onSelect: (index) {
                      setState(() {
                        selectedContainer = index;
                        potentialXP = 1000;
                      });
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(
                        top: 10, right: 50, left: 50, bottom: 10) /
                    1.2,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      int cost = giftCosts[selectedContainer];
                      if (diamondBalance >= cost) {
                        diamondBalance -= cost;
                        userXP += potentialXP;
                        potentialXP = 0;
                        // Call the _sendGift method
                        widget.onSendGift();
                      } else {
                        // Use ScaffoldMessenger to show the error message at the top
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Not enough diamonds!'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                top: 50.0, left: 20.0, right: 20.0),
                          ),
                        );
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedContainer == 0
                            ? 'Send 1 x Diamonds'
                            : selectedContainer == 1
                                ? 'Send 5 x Diamonds'
                                : 'Send 10 x Diamonds',
                        style: const TextStyle(
                            color: Color(0xffB9A588), fontSize: 15),
                      ),
                      const Icon(
                        Icons.send,
                        color: Color(0xffB9A588),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fetches the diamond balance
  Future<void> fetchDiamondBalance() async {
    // Fetch diamond balance from the server
    // Simulate fetching diamond balance from the server
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      diamondBalance = 10; // Simulated value
    });
  }
}
