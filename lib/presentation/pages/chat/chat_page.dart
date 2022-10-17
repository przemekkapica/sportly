import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.sm),
        child: Column(
          children: const [
            Text(
              'CHAT',
              style: AppTypo.titleSmall,
            )
          ],
        ),
      ),
    );
  }
}
