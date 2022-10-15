import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          LocaleKeys.offline_page_title.tr(),
        ),
      ),
    );
  }
}
