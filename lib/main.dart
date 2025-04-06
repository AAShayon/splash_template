import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CombinedSplashScreen(),
    );
  }
}

class CombinedSplashScreen extends StatefulWidget {
  @override
  _CombinedSplashScreenState createState() => _CombinedSplashScreenState();
}

class _CombinedSplashScreenState extends State<CombinedSplashScreen>
    with TickerProviderStateMixin {  // Changed to TickerProviderStateMixin
  late AnimationController _sunsetController;
  late Animation<double> _sunsetAnimation;

  late AnimationController _textController;
  late Animation<double> _textAnimation;
  late Animation<double> _welcomeAnimation;

  final String subtitle = "Your Business Solution Partner";

  @override
  void initState() {
    super.initState();

    // Sunset animation controller (3 seconds)
    _sunsetController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _sunsetAnimation = CurvedAnimation(
      parent: _sunsetController,
      curve: Curves.easeInOut,
    );

    // Text animation controller (starts after sunset completes)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Interval(0.0, 0.75, curve: Curves.easeOut),
      ),
    );

    _welcomeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start animations in sequence
    _sunsetController.forward().then((_) {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _sunsetController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_sunsetController, _textController]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.lerp(
                    Color(0xFFFFD700),
                    Color(0xFFFF4500),
                    _sunsetAnimation.value,
                  )!,
                  Color.lerp(
                    Color(0xFFFFA500),
                    Color(0xFF8B0000),
                    _sunsetAnimation.value,
                  )!,
                  Color.lerp(
                    Color(0xFF4B0082),
                    Color(0xFF000000),
                    _sunsetAnimation.value,
                  )!,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Sun animation (part of sunset)
                Positioned(
                  top: screenHeight * 0.3 * _sunsetAnimation.value,
                  left: screenWidth * 0.4,
                  child: SunWidget(animationValue: _sunsetAnimation.value),
                ),

                // Business Manager text - appears after sunset completes
                if (_sunsetController.isCompleted) ...[
                  Center(
                    child: Opacity(
                      opacity: _textAnimation.value,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.translate(
                            offset: Offset(
                              -screenWidth * 0.2 * (1 - _textAnimation.value),
                              0,
                            ),
                            child: Text(
                              "Business",
                              style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.5),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Transform.translate(
                            offset: Offset(
                              screenWidth * 0.2 * (1 - _textAnimation.value),
                              0,
                            ),
                            child: Text(
                              "Manager",
                              style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.5),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Subtitle
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.1),
                      child: Opacity(
                        opacity: _textAnimation.value,
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Welcome text
                  Transform.translate(
                    offset: Offset(
                      0,
                      screenHeight * 0.2 * (1 - _welcomeAnimation.value),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.2),
                        child: Opacity(
                          opacity: _welcomeAnimation.value,
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
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