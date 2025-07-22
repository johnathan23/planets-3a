import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroScreen extends ConsumerStatefulWidget {
  static const String screenName = 'intro';
  static const String path = '/$screenName';
  const IntroScreen({super.key});

  @override
  ConsumerState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
