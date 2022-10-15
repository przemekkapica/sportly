// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:sportly/presentation/pages/offline/offline_page.dart' as _i2;
import 'package:sportly/presentation/pages/teams/teams_page.dart' as _i1;

class MainRouter extends _i3.RootStackRouter {
  MainRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    TeamsPageRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.TeamsPage(),
        opaque: true,
      );
    },
    OfflinePageRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.OfflinePage(),
        opaque: true,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          TeamsPageRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          OfflinePageRoute.name,
          path: '/offline-page',
        ),
      ];
}

/// generated route for
/// [_i1.TeamsPage]
class TeamsPageRoute extends _i3.PageRouteInfo<void> {
  const TeamsPageRoute()
      : super(
          TeamsPageRoute.name,
          path: '/',
        );

  static const String name = 'TeamsPageRoute';
}

/// generated route for
/// [_i2.OfflinePage]
class OfflinePageRoute extends _i3.PageRouteInfo<void> {
  const OfflinePageRoute()
      : super(
          OfflinePageRoute.name,
          path: '/offline-page',
        );

  static const String name = 'OfflinePageRoute';
}
