import 'package:auto_route/auto_route.dart';
import 'package:sportly/presentation/pages/teams_page/teams_page.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(
      page: TeamsPage,
      initial: true,
    ),
  ],
)
class $MainRouter {}
