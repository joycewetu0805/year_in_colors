import 'package:flutter/material.dart';

/// Animation de rebond iOS-like
class BounceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double intensity;
  final bool autoPlay;
  final int repeatCount;
  final VoidCallback? onComplete;

  const BounceAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.intensity = 0.1,
    this.autoPlay = false,
    this.repeatCount = 1,
    this.onComplete,
  }) : super(key: key);

  @override
  _BounceAnimationState createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
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

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0 + widget.intensity),
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0 + widget.intensity, end: 1.0 - widget.intensity * 0.5),
        weight: 0.3,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0 - widget.intensity * 0.5, end: 1.0 + widget.intensity * 0.3),
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0 + widget.intensity * 0.3, end: 1.0),
        weight: 0.3,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.autoPlay) {
      _playAnimation();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      }
    });
  }

  void _playAnimation() {
    if (widget.repeatCount > 1) {
      _controller.repeat(count: widget.repeatCount);
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void bounce() {
    _controller.forward(from: 0.0);
  }

  void stop() {
    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Animation de rebond pour les succès
class SuccessBounceAnimation extends StatelessWidget {
  final Widget child;
  final bool show;

  const SuccessBounceAnimation({
    Key? key,
    required this.child,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: show ? child : const SizedBox.shrink(),
    );
  }
}