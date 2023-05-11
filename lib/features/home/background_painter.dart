import 'package:flutter/material.dart';

class CookingAppBackgroundPainter extends CustomPainter {
  void drawWavyLine(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final path = Path();
    final startY = size.height * 0.3;
    final endY = size.height * 0.0;
    const color = Colors.blue;

    path.moveTo(0, startY);
    path.quadraticBezierTo(
      size.width * 0.25,
      startY - size.height * 0.1,
      size.width * 0.5,
      startY,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      startY + size.height * 0.1,
      size.width,
      startY,
    );
    path.lineTo(size.width, endY);
    path.lineTo(0, endY);
    path.close();

    paint.color = color;
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // drawWavyLine(
    //   canvas,
    //   size,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
