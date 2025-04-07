import 'package:flutter/material.dart';

class SunWidget extends StatelessWidget {
  final double animationValue;
  final Color startColor;
  final Color endColor;

  const SunWidget({super.key,
    required this.animationValue,
    this.startColor = Colors.orange,
    this.endColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0 - (animationValue * 0.3),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color.lerp(startColor, endColor, animationValue)!,
              Color.lerp(Colors.yellow, Colors.deepOrange, animationValue)!,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Color.lerp(
                  startColor.withOpacity(0.5),
                  endColor.withOpacity(0.5),
                  animationValue)!,
              spreadRadius: 20,
              blurRadius: 50,
            ),
          ],
        ),
      ),
    );
  }
}