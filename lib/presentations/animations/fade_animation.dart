import 'package:flutter/material.dart';

/// Animation de fondu iOS-like
class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;
  final double end;
  final bool autoPlay;
  final bool fadeIn;
  final VoidCallback? onComplete;

  const FadeAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeIn,
    this.begin = 0.0,
    this.end = 1.0,
    this.autoPlay = true,
    this.fadeIn = true,
    this.onComplete,
  }) : super(key: key);

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.fadeIn ? widget.begin : widget.end,
      end: widget.fadeIn ? widget.end : widget.begin,
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

  void fadeOut() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// Animation de fondu en cascade pour les listes
class StaggeredFadeAnimation extends StatelessWidget {
  final int index;
  final int itemCount;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const StaggeredFadeAnimation({
    Key? key,
    required this.index,
    required this.itemCount,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delay = (index * (duration.inMilliseconds ~/ 3)).clamp(0, 500);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: duration.inMilliseconds + delay),
      curve: curve,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0.0, 20.0 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}