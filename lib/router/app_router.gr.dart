// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthHomeScreen(),
      );
    },
    CredentialsAuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CredentialsAuthScreen(),
      );
    },
    DiaryViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DiaryViewScreen(),
      );
    },
    MainAppRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainAppScreen(),
      );
    },
    AuthAppRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthAppScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    TokenAuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TokenAuthScreen(),
      );
    },
  };
}

/// generated route for
/// [AuthHomeScreen]
class AuthHomeRoute extends PageRouteInfo<void> {
  const AuthHomeRoute({List<PageRouteInfo>? children})
      : super(
          AuthHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CredentialsAuthScreen]
class CredentialsAuthRoute extends PageRouteInfo<void> {
  const CredentialsAuthRoute({List<PageRouteInfo>? children})
      : super(
          CredentialsAuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'CredentialsAuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiaryViewScreen]
class DiaryViewRoute extends PageRouteInfo<void> {
  const DiaryViewRoute({List<PageRouteInfo>? children})
      : super(
          DiaryViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiaryViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainAppScreen]
class MainAppRoute extends PageRouteInfo<void> {
  const MainAppRoute({List<PageRouteInfo>? children})
      : super(
          MainAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainAppRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthAppScreen]
class AuthAppRoute extends PageRouteInfo<void> {
  const AuthAppRoute({List<PageRouteInfo>? children})
      : super(
          AuthAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScaffoldWithSafeAreaRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TokenAuthScreen]
class TokenAuthRoute extends PageRouteInfo<void> {
  const TokenAuthRoute({List<PageRouteInfo>? children})
      : super(
          TokenAuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'TokenAuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
