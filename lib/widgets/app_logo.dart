import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/Utils/colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/ic_instagram.svg',
      color: primaryColor,
      height: 45,
    );
  }
}
