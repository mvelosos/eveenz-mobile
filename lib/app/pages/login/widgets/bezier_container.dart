import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/login/widgets/curve_painter.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: CurvePainter(),
      ),
    );
  }
}
