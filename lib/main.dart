import 'package:planets_3A/app/constants/app_constants.dart';
import 'package:planets_3A/app/router/app_router.dart';
import 'package:planets_3A/app/theme/app_theme.dart';
import 'package:planets_3A/core/db/session/session_manager.dart';
import 'package:planets_3A/core/utils/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/constants/app_environment.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  _setPreferredOrientations();
  _initSharedPreferences();
  await Environment.load();
  runApp(ProviderScope(child: const MyApp()));
}

void _setPreferredOrientations() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

void _initSharedPreferences() async {
  final session = SessionManager();
  await session.init();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: kAppName,
      theme: AppTheme.light,
      routerConfig: ref.watch(routerProvider),
      scrollBehavior: CustomScrollBehavior(),
    );
  }
}
