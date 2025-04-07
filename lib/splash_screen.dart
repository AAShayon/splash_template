import 'package:flutter/material.dart';
import 'package:splash_template/constant.dart';
import 'splash_controller.dart';
import 'sun_widget.dart';

class CustomSplashScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String welcomeText;
  final Duration sunsetDuration;
  final Duration textAnimationDuration;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle welcomeStyle;
  final Color sunStartColor;
  final Color sunEndColor;
  final String? logoSrc;
  final VoidCallback? onCompleted;

  const CustomSplashScreen({
    super.key,
    this.title = SplashConstants.defaultTitle,
    this.subtitle = SplashConstants.defaultSubtitle,
    this.welcomeText = SplashConstants.defaultWelcomeText,
    this.sunsetDuration = SplashConstants.defaultSunsetDuration,
    this.textAnimationDuration = SplashConstants.defaultTextAnimationDuration,
    this.titleStyle = SplashConstants.defaultTitleStyle,
    this.subtitleStyle = SplashConstants.defaultSubtitleStyle,
    this.welcomeStyle = SplashConstants.defaultWelcomeStyle,
    this.sunStartColor = SplashConstants.defaultSunColorStart,
    this.sunEndColor = SplashConstants.defaultSunColorEnd,
    this.onCompleted, this.logoSrc,
  });

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  late final SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController(
      vsync: this,
      sunsetDuration: widget.sunsetDuration,
      textAnimationDuration: widget.textAnimationDuration,
      onComplete: widget.onCompleted,
    );
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
                  Color.lerp(widget.sunStartColor, widget.sunEndColor, _controller.sunsetValue)!,
                  Color.lerp(const Color(0xFFFFA500), const Color(0xFF8B0000), _controller.sunsetValue)!,
                  Color.lerp(const Color(0xFF4B0082), const Color(0xFF000000), _controller.sunsetValue)!,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Sun animation
                Positioned(
                  top: screenHeight * 0.3 * _controller.sunsetValue,
                  left: screenWidth * 0.4,
                  child: SunWidget(
                    animationValue: _controller.sunsetValue,
                    startColor: widget.sunStartColor,
                    endColor: widget.sunEndColor,
                  ),
                ),

                // Title and subtitle appear after sunset completes
                if (_controller.isSunsetComplete) ...[
                  Center(
                    child: Opacity(
                      opacity: _controller.textValue,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.translate(
                            offset: Offset(
                              -screenWidth * 0.2 * (1 - _controller.textValue),
                              0,
                            ),
                            child: Text(
                              widget.title.split(' ')[0],
                              style: widget.titleStyle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Transform.translate(
                            offset: Offset(
                              screenWidth * 0.2 * (1 - _controller.textValue),
                              0,
                            ),
                            child: Text(
                              widget.title.split(' ')[1],
                              style: widget.titleStyle,
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
                        opacity: _controller.textValue,
                        child: Text(
                          widget.subtitle,
                          style: widget.subtitleStyle,
                        ),
                      ),
                    ),
                  ),

                  // Welcome text
                  Transform.translate(
                    offset: Offset(
                      0,
                      screenHeight * 0.2 * (1 - _controller.textValue),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.2),
                        child: Opacity(
                          opacity: _controller.textValue,
                          child: Text(
                            widget.welcomeText,
                            style: widget.welcomeStyle,
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