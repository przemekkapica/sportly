import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:sportly/presentation/pages/chat/chat_page.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page.dart';
import 'package:sportly/presentation/pages/home/home_page.dart';
import 'package:sportly/presentation/pages/auth_error/auth_error_page.dart';
import 'package:sportly/presentation/pages/join_team/join_team_page.dart';
import 'package:sportly/presentation/pages/offline/offline_page.dart';
import 'package:sportly/presentation/pages/profile/profile_page.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitaion_code_page.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page.dart';
import 'package:sportly/presentation/pages/teams/teams_page.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: HomePage,
      initial: true,
      path: '/',
      children: [
        AutoRoute(
          page: EmptyRouterPage,
          name: 'TeamsPageRouter',
          path: 'teams',
          children: [
            AutoRoute(
              page: TeamsPage,
              path: '',
              initial: true,
            ),
            AutoRoute(
              page: TeamDetailsPage,
              path: 'details',
            ),
            AutoRoute(
              page: CreateTeamPage,
              path: 'create',
            ),
            AutoRoute(
              page: ShareInvitationCodePage,
              path: 'share',
            ),
            AutoRoute(
              page: JoinTeamPage,
              path: 'share',
            ),
          ],
        ),
        AutoRoute(page: ChatPage),
        AutoRoute(page: SchedulePage),
        AutoRoute(page: ProfilePage),
      ],
    ),
    AutoRoute(page: SignInPage),
    AutoRoute(page: OfflinePage),
    AutoRoute(page: AuthErrorPage),
  ],
)
class $MainRouter {}
