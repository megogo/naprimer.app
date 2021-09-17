import 'dart:async';

import 'package:flutter/material.dart';

class ButtonWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final bool isBlocked;

  ButtonWrapper({
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.isBlocked = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ButtonWrapperState();
  }
}

class _ButtonWrapperState extends State<ButtonWrapper>
    with TickerProviderStateMixin {
  final Duration _animDuration = const Duration(milliseconds: 100);
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;
  bool _isTapUp = false;
  int _tapDownMillis = 0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: _animDuration, vsync: this);
    final curved =
    CurvedAnimation(curve: Curves.easeInOut, parent: _animController);
    _scaleAnim = Tween<double>(begin: 1, end: 0.97).animate(curved);
    _opacityAnim = Tween<double>(begin: 1, end: 0.7).animate(curved);
    curved.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (_isTapUp && widget.onTap != null) {
          // end of reverse animation
          _animController.stop();
          widget.onTap!();
        }
        _isTapUp = false;
      }
    });
  }

  @override
  void dispose() {
    _animController.stop();
    _animController.dispose();
    super.dispose();
  }

  void _onTapUp() {
    _isTapUp = true;
    _animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isBlocked
          ? null
          : (details) {
        _tapDownMillis = DateTime.now().millisecondsSinceEpoch;
        _animController.forward();
      },
      onTapUp: widget.isBlocked
          ? null
          : (details) {
        final dMillis =
            DateTime.now().millisecondsSinceEpoch - _tapDownMillis;
        if (dMillis < _animDuration.inMilliseconds) {
          Timer(
            Duration(
                milliseconds: _animDuration.inMilliseconds - dMillis),
            _onTapUp,
          );
        } else {
          _onTapUp();
        }
      },
      onTapCancel: widget.isBlocked
          ? null
          : () {
        _animController.reverse();
      },
      onDoubleTap: widget.onDoubleTap,
      child: FadeTransition(
        opacity: _opacityAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: widget.child,
        ),
      ),
    );
  }
}
