import 'package:flutter/material.dart';

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  
  static Curve get easeInOut => Curves.easeInOut;
  static Curve get easeOut => Curves.easeOut;
  static Curve get elasticOut => Curves.elasticOut;
  
  static Animation<double> createScaleAnimation(AnimationController controller) {
    return Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );
  }
  
  static Animation<double> createFadeAnimation(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
  }
  
  static Widget buildScaleTransition({
    required AnimationController controller,
    required Widget child,
  }) {
    return ScaleTransition(
      scale: createScaleAnimation(controller),
      child: child,
    );
  }
  
  static Widget buildFadeTransition({
    required AnimationController controller,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: createFadeAnimation(controller),
      child: child,
    );
  }
  
  static void showConfetti(BuildContext context) {
    // Placeholder pour l'animation de confetti
    // TODO: Implémenter avec flutter_confetti
  }
}