import 'package:auto_route/auto_route.dart';
import 'package:sportly/presentation/pages/offline/offline_page.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page.dart';
import 'package:sportly/presentation/pages/teams/teams_page.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(
      page: SignInPage,
      initial: true,
    ),
    AdaptiveRoute(
      page: TeamsPage,
    ),
    AdaptiveRoute(
      page: OfflinePage,
    ),
  ],
)
class $MainRouter {}
