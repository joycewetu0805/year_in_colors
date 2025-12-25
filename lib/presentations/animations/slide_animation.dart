import 'package:flutter/material.dart';

/// Animation de glissement iOS-like
class SlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset begin;
  final Offset end;
  final bool autoPlay;
  final AxisDirection direction;
  final VoidCallback? onComplete;

  const SlideAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeInOut,
    this.begin = Offset.zero,
    this.end = Offset.zero,
    this.autoPlay = true,
    this.direction = AxisDirection.down,
    this.onComplete,
  }) : super(key: key);

  factory SlideAnimation.fromDirection({
    required Widget child,
    required AxisDirection direction,
    double distance = 20.0,
    Duration duration = const Duration(milliseconds: 400),
    bool autoPlay = true,
  }) {
    final offsets = {
      AxisDirection.up: Offset(0, distance),
      AxisDirection.down: Offset(0, -distance),
      AxisDirection.left: Offset(distance, 0),
      AxisDirection.right: Offset(-distance, 0),
    };

    return SlideAnimation(
      child: child,
      begin: offsets[direction] ?? Offset.zero,
      end: Offset.zero,
      duration: duration,
      autoPlay: autoPlay,
      direction: direction,
    );
  }

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    if (widget.autoPlay) {
      _controller.forward();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onComplete != null) {
        widget.onComplete!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void play() {
    _controller.forward(from: 0.0);
  }

  void reverse() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

/// Animation de glissement pour les pages (navigation iOS)
class PageSlideAnimation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final bool isEntering;

  const PageSlideAnimation({
    Key? key,
    required this.child,
    required this.animation,
    this.isEntering = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final curve = Curves.easeInOut;
    final tween = Tween<Offset>(
      begin: isEntering ? const Offset(1.0, 0.0) : const Offset(-0.3, 0.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: curve));

    final offsetAnimation = animation.drive(tween);

    final opacityTween = Tween<double>(
      begin: isEntering ? 0.0 : 1.0,
      end: isEntering ? 1.0 : 0.0,
    ).chain(CurveTween(curve: curve));

    final opacityAnimation = animation.drive(opacityTween);

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: child,
      ),
    );
  }
}