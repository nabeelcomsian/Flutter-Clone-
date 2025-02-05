import 'package:flutter/material.dart';
import 'package:instagram/Utils/dimension.dart';

class ResponsiveLayoutScreen extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayoutScreen(
      {super.key,
      required this.mobileScreenLayout,
      required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          debugPrint('web version');
          return webScreenLayout;
        }
        debugPrint('mobile version');
        return mobileScreenLayout;
      },
    );
  }
}
