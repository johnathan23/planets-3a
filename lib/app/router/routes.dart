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
    path: DetailScreen.path,
    pageBuilder: (context, state) {
      final PlanetModel? planetModel = state.extra as PlanetModel?;
      return PageTransitions(
        screen: DetailScreen(planetModel: planetModel),
        transitionType: TransitionType.slide,
        durationTransition: k500milSec,
      );
    },
  ),
];
