import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  late Animation<double> _gradientAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _welcomeAnimation;
  final String appName = "Business Manager";
  final String subtitle = "Your Business Solution Partner";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Gradient animation (first 2 seconds)
    _gradientAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0, 0.5, curve: Curves.easeInOut),
        ));

        // Text animation (starts after gradient completes)
        _textAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.5, 0.85, curve: Curves.easeOut),
        ));

        // Welcome animation (last to appear)
        _welcomeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.7, 1.0, curve: Curves.easeOut),
        ));

        _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
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
                    _gradientAnimation.value,
                  )!,
                  Color.lerp(
                    Color(0xFFFFA500),
                    Color(0xFF8B0000),
                    _gradientAnimation.value,
                  )!,
                  Color.lerp(
                    Color(0xFF4B0082),
                    Color(0xFF000000),
                    _gradientAnimation.value,
                  )!,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Business Manager text - comes together in one row
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.3),
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
                ),

                // Subtitle - fades in at center
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.4),
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

                // Welcome text - comes from bottom
                Transform.translate(
                  offset: Offset(
                    0,
                    screenHeight * 0.2 * (1 - _welcomeAnimation.value),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.6),
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
            ),
          );
        },
      ),
    );
  }
}