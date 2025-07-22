part of 'app_router.dart';

final appRoutes = [
  // ? Add your routes here
  GoRoute(
    name: IntroScreen.screenName,
    path: IntroScreen.path,
    pageBuilder:
        (context, state) => PageTransitions(
          screen: IntroScreen(),
          transitionType: TransitionType.scale,
          durationTransition: k500milSec,
        ),
  ),
  GoRoute(
    name: HomeScreen.screenName,
    path: HomeScreen.path,
    pageBuilder:
        (context, state) =>
            PageTransitions(screen: HomeScreen(), transitionType: TransitionType.fade, durationTransition: k500milSec),
  ),
  GoRoute(
    name: DetailScreen.screenName,
    path: '${DetailScreen.path}/:planetName',
    pageBuilder: (context, state) {
      final String? planetName = state.pathParameters['planetName'];
      return PageTransitions(
        screen: DetailScreen(planetName: planetName),
        transitionType: TransitionType.slide,
        durationTransition: k500milSec,
      );
    },
  ),
];
