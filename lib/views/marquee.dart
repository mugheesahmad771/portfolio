import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Infinite auto-scrolling horizontal marquee: renders [child] twice back
/// to back and continuously slides left, wrapping seamlessly once the first
/// copy has scrolled fully past. [child]'s width is measured after first
/// layout, so it should have a stable intrinsic width (e.g. a `Row` of
/// fixed-size chips) — [height] must be supplied since the content is laid
/// out via an [OverflowBox], which can't size itself from the child.
class Marquee extends StatefulWidget {
  final Widget child;
  final double height;
  final double pixelsPerSecond;

  const Marquee({
    super.key,
    required this.child,
    required this.height,
    this.pixelsPerSecond = 40,
  });

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  late final Ticker _ticker;
  final GlobalKey _contentKey = GlobalKey();
  double _contentWidth = 0;
  double _offset = 0;
  Duration _last = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick)..start();
    SchedulerBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final box = _contentKey.currentContext?.findRenderObject();
    if (box is RenderBox && box.hasSize && box.size.width != _contentWidth) {
      setState(() => _contentWidth = box.size.width);
    }
  }

  void _onTick(Duration elapsed) {
    if (_contentWidth <= 0) {
      _last = elapsed;
      _measure();
      return;
    }
    final deltaSeconds = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    setState(() {
      _offset =
          (_offset + widget.pixelsPerSecond * deltaSeconds) % _contentWidth;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: ClipRect(
        child: RepaintBoundary(
          child: OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment.centerLeft,
            child: Transform.translate(
              offset: Offset(-_offset, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KeyedSubtree(key: _contentKey, child: widget.child),
                  widget.child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
