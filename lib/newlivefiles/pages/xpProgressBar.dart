import 'package:flutter/material.dart';

class XPProgressBar extends StatelessWidget {
  final int userXP;
  final int potentialXP;
  final List<String> ranks;
  final double width;

  const XPProgressBar(
      {Key? key,
      required this.userXP,
      required this.potentialXP,
      required this.ranks,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the current rank index and required XP
    int currentRankIndex = (userXP / 1000).floor() % ranks.length;
    int nextRankIndex = (userXP + potentialXP) ~/ 1000 % ranks.length;

    int requiredXP =
        (currentRankIndex + 1) * 1000; // XP required for the current rank
    int nextRequiredXP =
        (nextRankIndex + 1) * 1000; // XP required for the next rank

    // Ensure the shadow bar does not exceed the next rank's requirement
    int totalXP = (userXP + potentialXP).clamp(0, nextRequiredXP);

    return Stack(
      children: [
        Container(
          height: 12,
          width: width, // Fixed width for the progress bar
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff4A4A4A),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          // Actual XP bar
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: userXP / requiredXP,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 91, 0, 0).withOpacity(0.7),
              ),
            ),
          ),
        ),
        // Shadow progress bar showing potential XP
        Container(
          height: 10,
          width: width, // Same width as the actual progress bar
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: totalXP / nextRequiredXP,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(213, 126, 109, 0).withOpacity(0.3),
              ),
            ),
          ),
        ),
        // Text showing total XP and required XP
        Positioned(
          right: 80,
          top: 0,
          bottom: 0,
          child: Center(
            child: Text(
              '$totalXP / $nextRequiredXP',
              style: const TextStyle(
                color: Color(0xffB9A588),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
