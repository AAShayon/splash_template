import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  final AnimationController _sunsetController;
  final AnimationController _textController;

  SplashController({
    required TickerProvider vsync,
    required Duration sunsetDuration,
    required Duration textAnimationDuration,
    VoidCallback? onComplete,
  }) :
        _sunsetController = AnimationController(vsync: vsync, duration: sunsetDuration),
        _textController = AnimationController(vsync: vsync, duration: textAnimationDuration) {
    _init(onComplete);
  }

  void _init(VoidCallback? onComplete) {
    _sunsetController.forward().then((_) {
      _textController.forward().then((_) {
        onComplete?.call();
      });
    });
  }

  double get sunsetValue => _sunsetController.value;
  double get textValue => _textController.value;
  bool get isSunsetComplete => _sunsetController.isCompleted;

  @override
  void dispose() {
    _sunsetController.dispose();
    _textController.dispose();
    super.dispose();
  }
}