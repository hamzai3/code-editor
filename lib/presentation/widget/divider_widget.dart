import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double height;

  const DividerWidget({super.key, this.height = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
