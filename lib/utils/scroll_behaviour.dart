import 'package:flutter/material.dart';

class RemoveScrollGlow extends StatelessWidget {
  const RemoveScrollGlow({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(behavior: MyBehavior(), child: child);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
