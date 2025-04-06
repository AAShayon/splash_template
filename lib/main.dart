import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SunsetSplashScreen(),
    );
  }
}

class SunsetSplashScreen extends StatefulWidget {
  @override
  _SunsetSplashScreenState createState() => _SunsetSplashScreenState();
}

class _SunsetSplashScreenState extends State<SunsetSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.lerp(
                      Color(0xFFFFD700), // Gold
                      Color(0xFFFF4500), // OrangeRed
                      _animation.value,
                    )!,
                    Color.lerp(
                      Color(0xFFFFA500), // Orange
                      Color(0xFF8B0000), // DarkRed
                      _animation.value,
                    )!,
                    Color.lerp(
                      Color(0xFF4B0082), // Indigo
                      Color(0xFF000000), // Black
                      _animation.value,
                    )!,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.2 * _animation.value,
                    left: MediaQuery.of(context).size.width * 0.4,
                    child: SunWidget(animationValue: _animation.value),
                  ),
                  Center(
                    child: Opacity(
                      opacity: _animation.value,
                      child: const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SunWidget extends StatelessWidget {
  final double animationValue;

  const SunWidget({required this.animationValue});

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
              Color.lerp(Colors.orange, Colors.red, animationValue)!,
              Color.lerp(Colors.yellow, Colors.deepOrange, animationValue)!,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Color.lerp(Colors.orange.withOpacity(0.5),
                  Colors.deepOrange.withOpacity(0.5), animationValue)!,
              spreadRadius: 20,
              blurRadius: 50,
            ),
          ],
        ),
      ),
    );
  }
}