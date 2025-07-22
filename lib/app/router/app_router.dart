import 'package:planets_3A/app/router/transitions/page_transitions.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/domain/enum/log_level_enum.dart';
import 'package:planets_3A/domain/enum/transition_type_enum.dart';
import 'package:planets_3A/presentation/ui/detail/screens/detail_screen.dart';
import 'package:planets_3A/presentation/ui/home/screens/home_screen.dart';
import 'package:planets_3A/presentation/ui/intro/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:planets_3A/core/utils/custom_console.dart';

part 'app_router.g.dart';

part 'routes.dart';

@riverpod
class Router extends _$Router {
  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  @override
  GoRouter build() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: IntroScreen.path,
      redirect: _redirect,
      routes: appRoutes,
    );
  }

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    final String path = state.uri.path;

    CustomConsole.log(
      message:
          'falls into redirection => name:${state.name}, path: ${state.path}, pathParams: ${state.pathParameters}, topRoute: ${state.topRoute}, extra: ${state.extra}, fullPath: ${state.fullPath}, uri: ${state.uri}, error: ${state.error}',
      level: LogLevel.info,
    );

    if (path == '/' || !_isPathValid(path)) {
      return IntroScreen.path;
    }

    return null;
  }

  bool _isPathValid(String path) {
    return appRoutes.any((route) => route.path == path);
  }
}
