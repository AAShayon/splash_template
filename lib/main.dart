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
  final String appName = "Business Manager";
  final String subtitle = "Your Business Solution Partner";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

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
                      Color(0xFFFFD700),
                      Color(0xFFFF4500),
                      _animation.value,
                    )!,
                    Color.lerp(
                      Color(0xFFFFA500),
                      Color(0xFF8B0000),
                      _animation.value,
                    )!,
                    Color.lerp(
                      Color(0xFF4B0082),
                      Color(0xFF000000),
                      _animation.value,
                    )!,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Business - Coming from left
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1500),
                    left: screenWidth * 0.4 * (1 - _animation.value) - 200,
                    top: screenHeight * 0.4,
                    child: Opacity(
                      opacity: _animation.value,
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
                  ),

                  // Manager - Coming from right
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1500),
                    right: screenWidth * 0.4 * (1 - _animation.value) - 200,
                    top: screenHeight * 0.4,
                    child: Opacity(
                      opacity: _animation.value,
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
                  ),

                  // Welcome - Coming from bottom
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1500),
                    bottom: screenHeight * 0.2 * (1 - _animation.value),
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: _animation.value,
                      child: Text(
                        "Welcome",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),

                  // Merged App Name
                  Positioned(
                    top: screenHeight * 0.4,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: _animation.value,
                      child: Column(
                        children: [
                          Text(
                            appName,
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
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