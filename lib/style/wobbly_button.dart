import 'dart:math';

import 'package:flutter/material.dart';

class WobblyButton extends StatefulWidget {
  const WobblyButton({required this.child, super.key, this.onPressed});
  final Widget child;

  final VoidCallback? onPressed;

  @override
  State<WobblyButton> createState() => _WobblyButtonState();
}

class _WobblyButtonState extends State<WobblyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _controller.repeat();
      },
      onExit: (event) {
        _controller.stop(canceled: false);
      },
      child: RotationTransition(
        turns: _controller.drive(const _MySineTween(0.005)),
        child: MaterialButton(
          onPressed: widget.onPressed,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _MySineTween extends Animatable<double> {
  const _MySineTween(this.maxExtent);
  final double maxExtent;

  @override
  double transform(double t) {
    return sin(t * 2 * pi) * maxExtent;
  }
}
