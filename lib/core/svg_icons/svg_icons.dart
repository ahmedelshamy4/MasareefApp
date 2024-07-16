import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String iconName;
  final double height;
  final double width;
  final bool transformForEnglish;
  final Color? color;
  final BoxFit? fit;

  const SvgIcon({
    super.key,
    required this.iconName,
    this.height = 20,
    this.width = 20,
    this.transformForEnglish = false,
    this.color, this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: transformForEnglish
          ? Matrix4.rotationY(math.pi)
          : (Matrix4.rotationY(math.pi * 2)),
      child: SvgPicture.asset(
        'assets/masareef_icons/$iconName',
        height: height,
        width: width,
        colorBlendMode: BlendMode.srcIn,
        fit: fit ?? BoxFit.cover,
        color: color,
      ),
    );
  }
}
