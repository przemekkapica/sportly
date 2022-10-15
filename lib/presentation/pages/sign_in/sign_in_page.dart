import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(LocaleKeys.sign_in_page_button_label.tr()),
        ),
      ),
    );
  }
}
