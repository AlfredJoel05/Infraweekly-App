import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page1.dart';
import 'onboarding_page2.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class ScrollDisglow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _OnboardingPageState extends State<OnboardingPage> {
  
  final PageController _pageIndex = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: ScrollDisglow(),
            child: PageView(
              controller: _pageIndex,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const OnBoardPage1(),
                const OnboardPage2(),
              ],
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: _pageIndex, 
              count: 2,
              effect: const ExpandingDotsEffect(
                radius: 16.0,
                dotWidth: 16.0,
                dotHeight: 11.5,
                dotColor: Color.fromARGB(255, 232, 232, 232),
                activeDotColor: Color.fromARGB(255, 255, 189, 8),
              ),
              ),
            ),
        ],
      ),
    );
  }
}
