import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package

class GiftWidget extends StatefulWidget {
  static OverlayEntry? currentGiftEntries;
  static List<String> giftEntryPathCache = [];

  static void show(BuildContext context, String giftPath) {
    if (null != currentGiftEntries) {
      debugPrint("Has gift displaying, cache $giftPath");

      giftEntryPathCache.add(giftPath);

      return;
    }

    currentGiftEntries = OverlayEntry(builder: (context) {
      return GiftWidget(
        giftPath: giftPath,
        onRemove: () {
          if (currentGiftEntries?.mounted ?? false) {
            currentGiftEntries?.remove();
          }
          currentGiftEntries = null;

          if (giftEntryPathCache.isNotEmpty) {
            var nextGiftPath = giftEntryPathCache.first;
            giftEntryPathCache.removeAt(0);

            debugPrint("Has gift cache, play $nextGiftPath");

            GiftWidget.show(context, nextGiftPath);
          }
        },
      );
    });

    Overlay.of(context, rootOverlay: false).insert(currentGiftEntries!);
  }

  static bool clear() {
    if (currentGiftEntries?.mounted ?? false) {
      currentGiftEntries?.remove();
    }

    return true;
  }

  const GiftWidget({Key? key, required this.onRemove, required this.giftPath})
      : super(key: key);

  final VoidCallback onRemove;
  final String giftPath;

  @override
  State<GiftWidget> createState() => GiftWidgetState();
}

class GiftWidgetState extends State<GiftWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.giftPath,
      controller: animationController,
      onLoaded: (composition) {
        animationController
          ?..duration = composition.duration
          ..forward().whenComplete(widget.onRemove);
      },
    );
  }
}
