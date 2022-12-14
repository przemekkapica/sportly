import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:sportly/presentation/pages/chat/chat_page.dart';
import 'package:sportly/presentation/pages/chat_entry/chat_entry_page.dart';
import 'package:sportly/presentation/pages/create_event/create_event_page.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page.dart';
import 'package:sportly/presentation/pages/edit_event/edit_event_page.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page.dart';
import 'package:sportly/presentation/pages/home/home_page.dart';
import 'package:sportly/presentation/pages/auth_error/auth_error_page.dart';
import 'package:sportly/presentation/pages/join_team/join_team_page.dart';
import 'package:sportly/presentation/pages/offline/offline_page.dart';
import 'package:sportly/presentation/pages/profile/profile_page.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page.dart';
import 'package:sportly/presentation/pages/schedule_entry/schedule_entry_page.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitaion_code_page.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page.dart';
import 'package:sportly/presentation/pages/team_management/team_management_page.dart';
import 'package:sportly/presentation/pages/teams/teams_page.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: SignInPage,
      initial: true,
    ),
    AutoRoute(page: OfflinePage),
    AutoRoute(page: AuthErrorPage),
    AutoRoute(
      page: HomePage,
      // initial: true,
      path: '/',
      children: [
        AutoRoute(
          page: EmptyRouterPage,
          name: 'TeamsRouter',
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
              path: 'create-team',
            ),
            AutoRoute(
              page: JoinTeamPage,
              path: 'join-team',
            ),
            AutoRoute(
              page: ShareInvitationCodePage,
              path: 'share',
            ),
            AutoRoute(
              page: TeamManagementPage,
              path: 'manage',
            ),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'ChatRouter',
          path: 'chat',
          children: [
            AutoRoute(
              page: ChatEntryPage,
              path: '',
              initial: true,
            ),
            AutoRoute(
              page: ChatPage,
              path: 'page',
            ),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'ScheduleRouter',
          path: 'schedule',
          children: [
            AutoRoute(
              page: ScheduleEntryPage,
              path: '',
              initial: true,
            ),
            AutoRoute(
              page: SchedulePage,
              path: 'page',
            ),
            AutoRoute(
              page: CreateEventPage,
              path: 'create-event',
            ),
            AutoRoute(
              page: EventsListPage,
              path: 'events-list',
            ),
            AutoRoute(
              page: EditEventPage,
              path: 'edit-event',
            ),
          ],
        ),
        AutoRoute(
          page: ProfilePage,
          path: 'profile',
        ),
      ],
    ),
  ],
)
class $MainRouter {}
