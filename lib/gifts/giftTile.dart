import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class GiftTile extends StatelessWidget {
  final int index;
  final IconData icon;
  final Color color;
  final String count;
  final int xp;
  final int selectedContainer;
  final Function(int) onSelect;

  const GiftTile({
    Key? key,
    required this.index,
    required this.icon,
    required this.color,
    required this.count,
    required this.xp,
    required this.selectedContainer,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(index);
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1.5,
            color: selectedContainer == index
                ? Colors.amber // Highlight color when selected
                : const Color(0xffB9A588),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 20,
              child: Marquee(
                text: 'Handful Of Diamonds',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xffB9A588),
                ),
                scrollAxis: Axis.horizontal,
                blankSpace: 20.0,
                velocity: 30.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    color: Color(0xffB9A588),
                  ),
                ),
                const Icon(
                  Icons.diamond,
                  color: Color(0xffB9A588),
                  size: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
