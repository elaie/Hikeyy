import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color dotColor;
  final Color activeDotColor;

  const CustomDotIndicator({super.key, 
    required this.itemCount,
    required this.currentIndex,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.black,
  });

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 12.0 : 8.0,
      height: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? activeDotColor : dotColor,
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        itemCount,
        (int index) => _buildDot(index == currentIndex),
      ),
    );
  }
}
