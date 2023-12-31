import 'package:flutter/material.dart';

class MyGapWidget extends StatelessWidget {
  final double size;

  MyGapWidget(this.size);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
    );
  }
}
