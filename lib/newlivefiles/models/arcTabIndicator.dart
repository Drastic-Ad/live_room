import 'package:flutter/material.dart';

class ArcTabIndicator extends Decoration {
  final Color color;
  final double height;

  ArcTabIndicator({required this.color, required this.height});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ArcPainter(color: color, height: height);
  }
}

class _ArcPainter extends BoxPainter {
  final Color color;
  final double height;

  _ArcPainter({required this.color, required this.height});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    final Rect rect = Offset(
          offset.dx,
          configuration.size!.height - height,
        ) &
        Size(configuration.size!.width, height);

    final path = Path();
    path.moveTo(rect.left, rect.bottom);
    path.quadraticBezierTo(
        rect.center.dx, rect.top - height, rect.right, rect.bottom);
    path.lineTo(rect.right, rect.bottom);
    path.lineTo(rect.left, rect.bottom);
    path.close();

    canvas.drawPath(path, paint);
  }
}
