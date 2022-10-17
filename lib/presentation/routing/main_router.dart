import 'package:auto_route/auto_route.dart';
import 'package:sportly/presentation/pages/chat/chat_page.dart';
import 'package:sportly/presentation/pages/home/home_page.dart';
import 'package:sportly/presentation/pages/offline/offline_page.dart';
import 'package:sportly/presentation/pages/profile/profile_page.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page.dart';
import 'package:sportly/presentation/pages/teams/teams_page.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(
      page: SignInPage,
    ),
    AdaptiveRoute(
      page: OfflinePage,
    ),
    AdaptiveRoute(
      page: HomePage,
      initial: true,
      children: [
        AdaptiveRoute(page: TeamsPage),
        AdaptiveRoute(page: ChatPage),
        AdaptiveRoute(page: SchedulePage),
        AdaptiveRoute(page: ProfilePage),
      ],
    ),
  ],
)
class $MainRouter {}
