import 'package:flutter/material.dart';

class SplashConstants {
  static const String defaultTitle = "Business Manager";
  static const String defaultSubtitle = "Your Business Solution Partner";
  static const String defaultWelcomeText = "Welcome";

  static const Duration defaultSunsetDuration = Duration(seconds: 3);
  static const Duration defaultTextAnimationDuration = Duration(seconds: 2);

  static const Color defaultSunColorStart = Color(0xFFFFD700);
  static const Color defaultSunColorEnd = Color(0xFFFF4500);

  static const TextStyle defaultTitleStyle = TextStyle(
    fontSize: 34,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(blurRadius: 10, color: Colors.black54),
    ],
  );

  static const TextStyle defaultSubtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  static const TextStyle defaultWelcomeStyle = TextStyle(
    fontSize: 28,
    color: Colors.white70,
    fontStyle: FontStyle.italic,
  );
}