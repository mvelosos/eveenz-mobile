import 'package:flutter/material.dart';

class SignUpBezierContainer extends StatelessWidget {
  const SignUpBezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: size.height,
      width: size.width,
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
    paint.color = Color(0xFFC4C4C4).withOpacity(.2);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * .19);
    path.quadraticBezierTo(
      size.width * .25,
      (size.height * .22) * .68,
      size.width / 2,
      size.height * .19,
    );
    path.quadraticBezierTo(
      size.width,
      size.height * .26,
      size.width,
      size.height * .24,
    );
    path.lineTo(size.width, size.height * .27);
    path.lineTo(size.height, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
