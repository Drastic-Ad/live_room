import 'package:flutter/material.dart';

class EllipseTabIndicator extends Decoration {
  final Color color;
  final Size size;

  EllipseTabIndicator({required this.color, required this.size});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _EllipsePainter(color: color, size: size);
  }
}

class _EllipsePainter extends BoxPainter {
  final Color color;
  final Size size;

  _EllipsePainter({required this.color, required this.size});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    final Offset ellipseOffset = offset +
        Offset(
          (configuration.size!.width - size.width) / 2,
          configuration.size!.height - size.height / 2,
        );
    final Rect rect = ellipseOffset & size;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(size.height / 2)),
      paint,
    );
  }
}
