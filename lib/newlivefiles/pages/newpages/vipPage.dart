import 'package:flutter/material.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/models/arcTabIndicator.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/main.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/pages/newpages/nobilityUpgradeRulespage.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/pages/newpages/showVIPoptions.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/pages/xpProgressBar.dart';
// Import the custom circle tab indicator

class VIPPage extends StatelessWidget {
  // Dummy data for demonstration
  final String userName = 'user_$localUserID';
  final String userRank = "Gold";
  final int userXP = 2000;
  final int totalXP = 5000;

  VIPPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> ranks = [
      'Iron',
      'Bronze',
      'Silver',
      'Gold',
      'Platinum',
      'Diamond',
      'Immortal',
      'Radiant'
    ];

    return DefaultTabController(
      length: ranks.length,
      child: Scaffold(
        backgroundColor: const Color(0xff0E0E0E),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xffB9A588), // Change your color here
          ),
          backgroundColor: const Color(0xff1D1D1D),
          title: const Text(
            '',
            style: TextStyle(
              color: Color(0xffB9A588),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {
                // do something
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.help,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpgradeHelpPage()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular avatar with user name
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
                color: const Color(0xff1D1D1D),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                const Color.fromARGB(255, 102, 73, 31),
                            child: Text(
                              userName[
                                  0], // Display the first letter of the user name
                              style: const TextStyle(
                                color: Color(0xffB9A588),
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            userName,
                            style: const TextStyle(
                              color: Color(0xffB9A588),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        child: Container(
                            height: 100,
                            child: Image.asset('assets/ranks/Gold_3_Rank.png')),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Rank card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                color: const Color(0xff1D1D1D),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'This Months EXP',
                            style: TextStyle(
                              color: Color(0xffB9A588),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          XPProgressBar(
                            width: 200,
                            userXP: userXP,
                            potentialXP: totalXP - userXP,
                            ranks: ranks,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xffB9A588),
                        radius: 25,
                        child: IconButton(
                            iconSize: 35,
                            color: const Color(
                              0xff1D1D1D,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ShowVipOptions());
                            },
                            icon: const Icon(Icons.arrow_upward_rounded)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // TabBar below the XP Progress Bar
              TabBar(
                labelColor: const Color(0xffB9A588),
                dividerColor: const Color(0xffB9A588),
                indicator: ArcTabIndicator(
                  color: const Color(0xffB9A588),
                  height: 8, // Adjust height to your preference
                ),
                isScrollable: true,
                tabs: ranks
                    .map((rank) => Tab(
                          text: rank,
                        ))
                    .toList(),
              ),
              // TabBarView for displaying content for each rank
              Expanded(
                child: TabBarView(
                  children: ranks.map((rank) {
                    return Center(
                      child: Text(
                        'Details for $rank rank',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffB9A588),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
