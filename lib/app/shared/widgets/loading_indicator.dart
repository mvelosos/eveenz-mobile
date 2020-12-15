import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoadingIndicator extends StatelessWidget {
  final BoxConstraints _constraints;

  LoadingIndicator(this._constraints);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _constraints.maxWidth,
      height: _constraints.maxHeight,
      color: Color.fromRGBO(0, 0, 0, .3),
      child: Center(
        child: Container(
          width: _constraints.maxWidth * .2,
          height: _constraints.maxHeight * .09,
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
