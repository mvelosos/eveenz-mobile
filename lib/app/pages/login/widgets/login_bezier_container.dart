import 'package:flutter/material.dart';

class LoginBezierContainer extends StatelessWidget {
  const LoginBezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: _CurvePainter(),
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFC4C4C4).withOpacity(.15);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * .33);
    path.quadraticBezierTo(
      size.width * .33,
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
