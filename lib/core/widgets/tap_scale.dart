import '../theme/app_tokens.dart';
import 'package:flutter/material.dart';

class TScale extends StatefulWidget {
  const TScale({
    super.key,
    required this.child,
    this.onTap,
    this.minScale = AppMotion.tapScale,
    this.duration = AppMotion.tap,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double minScale;
  final Duration duration;

  @override
  State<TScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<TScale> {
  double _scale = 1;

  void _setScale(double value) {
    if (!mounted) return;
    setState(() => _scale = value);
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onTap != null;

    return GestureDetector(
      onTapDown: enabled ? (_) => _setScale(widget.minScale) : null,
      onTapCancel: enabled ? () => _setScale(1) : null,
      onTapUp: enabled ? (_) => _setScale(1) : null,
      onTap: enabled ? widget.onTap : null,
      child: AnimatedScale(
        scale: _scale,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
