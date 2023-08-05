import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  final double radius;
  const LoadingComponent({super.key, this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: Colors.black,
      radius: radius,
    );
  }
}
