import 'package:flutter/material.dart';

// Custom Painter to draw stylized map roads for mock map
class MapRoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 24
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final borderPaint = Paint()
      ..color = const Color(0xFF107C41).withValues(alpha: 0.08)
      ..strokeWidth = 28
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Path 1
    path.moveTo(0, size.height * 0.3);
    path.lineTo(size.width * 0.4, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.3,
      size.width * 0.6,
      size.height * 0.6,
    );
    path.lineTo(size.width * 0.6, size.height);

    // Path 2
    path.moveTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.2, size.height * 0.7);
    path.lineTo(size.width, size.height * 0.7);

    // Draw borders then roads
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, paint);

    // Draw highway dots
    final dotPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
