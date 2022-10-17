import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_assets.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

class HorizontalAppLogo extends StatelessWidget {
  const HorizontalAppLogo({
    Key? key,
    this.width = AppDimens.horizontalLogoHeight,
    this.height = AppDimens.horizontalLogoHeight,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(AppAssets.horizontalLogo),
      width: width,
      height: height,
    );
  }
}
