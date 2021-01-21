import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFC4C4C4).withOpacity(.15);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * .33);
    path.quadraticBezierTo(
      size.width * .25,
      (size.height * .36) * .82,
      size.width / 2,
      size.height * .33,
    );
    path.quadraticBezierTo(
      size.width,
      size.height * .40,
      size.width,
      size.height * .38,
    );
    path.lineTo(size.width, size.height * .35);
    path.lineTo(size.height, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
