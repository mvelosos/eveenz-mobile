import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Color(0xFF000000).withOpacity(.3),
      child: Center(
        child: Container(
          width: size.height * .1,
          height: size.height * .09,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
