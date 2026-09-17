import 'package:flutter/material.dart';

/// Wraps [child] with a mouse-driven 3D tilt: the card rotates toward the
/// cursor's position within its bounds and springs back flat on exit. Pure
/// visual flourish — a perspective [Transform], so it never changes layout
/// or intercepts taps differently than [child] normally would.
class TiltCard extends StatefulWidget {
  final Widget child;

  /// Max rotation in radians at the card's edge.
  final double maxTilt;

  const TiltCard({super.key, required this.child, this.maxTilt = 0.1});

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  double _rotateX = 0;
  double _rotateY = 0;
  bool _hovering = false;

  void _updateFromLocal(Offset local, Size size) {
    if (size.width == 0 || size.height == 0) return;
    final dx = (local.dx / size.width).clamp(0.0, 1.0) - 0.5;
    final dy = (local.dy / size.height).clamp(0.0, 1.0) - 0.5;
    setState(() {
      _rotateY = dx * widget.maxTilt * 2;
      _rotateX = -dy * widget.maxTilt * 2;
    });
  }

  void _reset() {
    setState(() {
      _hovering = false;
      _rotateX = 0;
      _rotateY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scale = _hovering ? 1.02 : 1.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => _reset(),
      onHover: (event) {
        final box = context.findRenderObject();
        if (box is! RenderBox || !box.hasSize) return;
        _updateFromLocal(box.globalToLocal(event.position), box.size);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: _hovering ? 90 : 260),
        curve: Curves.easeOut,
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY)
          ..scaleByDouble(scale, scale, scale, 1.0),
        child: widget.child,
      ),
    );
  }
}
