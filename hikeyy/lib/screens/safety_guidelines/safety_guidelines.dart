import 'package:flutter/material.dart';
import 'package:hikeyy/screens/safety_guidelines/widgets/altitude_sickness.dart';
import 'package:hikeyy/screens/safety_guidelines/widgets/before_trekking.dart';
import 'package:hikeyy/screens/safety_guidelines/widgets/while_trekking.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

class SafetyGuidelines extends StatefulWidget {
  const SafetyGuidelines({super.key});

  @override
  State<SafetyGuidelines> createState() => _SafetyGuidelinesState();
}

class _SafetyGuidelinesState extends State<SafetyGuidelines> {
  final List<Widget> pages = [
    const BeforeTrekking(),
    const WhileTrekking(),
    const AltitudeSikness(),
  ];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page!.round();
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const AppText(
                    text: 'Safety Guidelines',
                    fontSize: 20,
                    color: AppColor.primaryDarkColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(pages.length, (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentPage == index ? 12.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? AppColor.primaryColor
                          : Colors.grey[400],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
