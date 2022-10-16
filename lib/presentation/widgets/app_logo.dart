import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_assets.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.width = AppDimens.logo,
    this.height = AppDimens.logo,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(AppAssets.logo),
      width: width,
      height: height,
    );
  }
}
