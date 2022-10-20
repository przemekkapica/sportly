import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:sportly/presentation/pages/chat/chat_page.dart';
import 'package:sportly/presentation/pages/home/home_page.dart';
import 'package:sportly/presentation/pages/offline/offline_page.dart';
import 'package:sportly/presentation/pages/profile/profile_page.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page.dart';
import 'package:sportly/presentation/pages/teams/teams_page.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: HomePage,
      path: '/',
      children: [
        AutoRoute(
          path: 'teams',
          name: 'TeamsPageRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              page: TeamsPage,
              path: '',
            ),
            AutoRoute(
              page: TeamDetailsPage,
              path: ':teamId',
            ),
          ],
        ),
        AutoRoute(
          page: ChatPage,
          path: 'chat',
        ),
        AutoRoute(
          page: SchedulePage,
          path: 'schedule',
        ),
        AutoRoute(
          page: ProfilePage,
          path: 'profile',
        ),

        // AutoRoute(
        //   page: SignInPage,
        //   path: 'sign-in',
        // ),
        // AutoRoute(
        //   page: OfflinePage,
        //   path: 'offline',
        // ),
      ],
    ),
  ],
)
class $MainRouter {}
