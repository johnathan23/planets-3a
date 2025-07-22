import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_decorations.dart';
import 'package:planets_3A/domain/enum/slide_direction_enum.dart';
import 'package:planets_3A/presentation/animations/fade_animation.dart';
import 'package:planets_3A/presentation/animations/slide_animation.dart';
import 'package:planets_3A/presentation/ui/home/screens/home_screen.dart';
import 'package:planets_3A/presentation/widgets/custom_large_button.dart';

class IntroScreen extends ConsumerStatefulWidget {
  static const String screenName = 'intro';
  static const String path = '/$screenName';
  const IntroScreen({super.key});

  @override
  ConsumerState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  void _navigateToHome() => context.goNamed(HomeScreen.screenName);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.background(kBackgroundGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.01,
                    left: constraints.maxWidth * 0.01,
                    child: SlideAnimation(
                      direction: SlideDirection.topToBottom,
                      child: Image.asset('assets/images/satellite.png', width: 90, height: 58, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.25,
                    right: (constraints.maxWidth * 0.01) - (constraints.maxWidth * 0.03),
                    child: SlideAnimation(
                      direction: SlideDirection.rightToLeft,
                      child: Image.asset('assets/images/moon.png', width: 68, height: 115, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.3,
                    width: constraints.maxWidth,
                    child: FadeAnimation(
                      child: Text(
                        'Explore \nThe Universe',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(color: kWhite),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.5,
                    left: constraints.maxWidth * 0.05,
                    child: SlideAnimation(
                      direction: SlideDirection.leftToRight,
                      child: Image.asset('assets/images/comet.png', width: 70, height: 50, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth / 2,
                    left: constraints.maxWidth * 0.25,
                    child: CustomLargeButton(
                      width: double.infinity,
                      backgroundColor: kWhite,
                      text: 'See Planets',
                      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: kBlack),
                      onPressed: _navigateToHome,
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.1,
                    child: SlideAnimation(
                      direction: SlideDirection.bottomToTop,
                      child: Image.asset('assets/images/astronaut.png', width: 380, height: 264, fit: BoxFit.contain),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
