import 'package:flutter/material.dart';
import 'dart:math' as math;

class MorphRing extends StatefulWidget {
  final double size;
  final String? label;

  const MorphRing({super.key, this.size = 40, this.label});

  @override
  State<MorphRing> createState() => _MorphRingState();
}

class _MorphRingState extends State<MorphRing> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) {
            final t = _ctrl.value;
            final scale = 1.0 + (0.07 * math.sin(t * math.pi * 4));
            final radius = 50.0 - (12.0 * math.sin(t * math.pi * 2).abs());

            return Transform.rotate(
              angle: t * 2 * math.pi,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.size * (radius / 100)),
                    gradient: const SweepGradient(
                      colors: [Color(0xFF89937E), Color(0xFF576966), Colors.transparent],
                      stops: [0.0, 0.45, 0.65],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widget.size * 0.125),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0C),
                        borderRadius: BorderRadius.circular(widget.size),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.label != null) ...[
          const SizedBox(height: 12),
          Text(widget.label!, style: const TextStyle(fontSize: 13, color: Colors.white54, letterSpacing: 1.2)),
        ]
      ],
    );
  }
}
