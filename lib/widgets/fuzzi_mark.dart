import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

const _palette = {
  'armor': Color(0xFF7a8a6e),
  'armorDark': Color(0xFF5a6654),
  'armorLight': Color(0xFF9aaa8e),
  'visor': Color(0xFFf5e642),
  'visorGlow': Color(0xFFffe100),
  'outline': Color(0xFF3a4235),
  'accent': Color(0xFFb8ff4e),
};

class FuzziMark extends StatefulWidget {
  final double size;
  const FuzziMark({super.key, this.size = 40});

  @override
  State<FuzziMark> createState() => _FuzziMarkState();
}

class _FuzziMarkState extends State<FuzziMark> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0;
      });
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      // Proporcje viewBox z oryginalnego SVG (-26 0 152 118)
      child: AspectRatio(
        aspectRatio: 152 / 118,
        child: CustomPaint(
          painter: _FuzziPainter(_time),
        ),
      ),
    );
  }
}

class _FuzziPainter extends CustomPainter {
  final double time;
  _FuzziPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    // Skalowanie do viewBoxa 152x118 i przesunięcie punktu 0,0 (-26 na X)
    canvas.scale(size.width / 152.0, size.height / 152.0);
    canvas.translate(26.0, 0.0);

    _drawLegs(canvas);
    _drawChelicerae(canvas);
    _drawArmor(canvas);
    _drawVisors(canvas);
    _drawSensorsAndLED(canvas);

    canvas.restore();
  }

  void _drawLegs(Canvas canvas) {
    final legs = [
      _LegDef(Offset(24, 44), Offset(6, 32), Offset(-4, 38), Offset(-16, 42), Offset(-20, 58), 0),
      _LegDef(Offset(22, 57), Offset(2, 50), Offset(-8, 54), Offset(-20, 58), Offset(-22, 74), 1),
      _LegDef(Offset(22, 68), Offset(0, 70), Offset(-6, 78), Offset(-14, 84), Offset(-8, 100), 2),
      _LegDef(Offset(26, 78), Offset(6, 84), Offset(4, 92), Offset(2, 100), Offset(6, 112), 3),
      _LegDef(Offset(76, 44), Offset(94, 32), Offset(104, 38), Offset(116, 42), Offset(120, 58), 0),
      _LegDef(Offset(78, 57), Offset(98, 50), Offset(108, 54), Offset(120, 58), Offset(122, 74), 1),
      _LegDef(Offset(78, 68), Offset(100, 70), Offset(106, 78), Offset(114, 84), Offset(108, 100), 2),
      _LegDef(Offset(74, 78), Offset(94, 84), Offset(96, 92), Offset(98, 100), Offset(94, 112), 3),
    ];

    for (var leg in legs) {
      canvas.save();
      final delay = leg.i * 0.2;
      final dir = leg.i % 2 == 0 ? 1 : -1;
      final t = ((time - delay) % 1.9) / 1.9;
      // Wygładzona rotacja animacji z CSS ease-in-out
      final rotation = math.sin((t - 0.5) * math.pi) * 0.15 * dir;

      canvas.translate(leg.r.dx, leg.r.dy);
      canvas.rotate(rotation);
      canvas.translate(-leg.r.dx, -leg.r.dy);

      final seg1 = Path()..moveTo(leg.r.dx, leg.r.dy)..quadraticBezierTo(leg.c1.dx, leg.c1.dy, leg.k.dx, leg.k.dy);
      final seg2 = Path()..moveTo(leg.k.dx, leg.k.dy)..quadraticBezierTo(leg.c2.dx, leg.c2.dy, leg.t.dx, leg.t.dy);

      canvas.drawPath(seg1, Paint()..color = _palette['outline']!..strokeWidth = 5.5..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
      canvas.drawPath(seg1, Paint()..color = _palette['armorDark']!..strokeWidth = 2.6..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
      canvas.drawPath(seg2, Paint()..color = _palette['outline']!..strokeWidth = 4.0..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
      canvas.drawPath(seg2, Paint()..color = _palette['armor']!..strokeWidth = 1.8..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);

      canvas.drawCircle(leg.k, 4.2, Paint()..color = _palette['armorDark']!);
      canvas.drawCircle(leg.k, 4.2, Paint()..color = _palette['outline']!..strokeWidth = 2..style = PaintingStyle.stroke);
      canvas.drawCircle(leg.k, 1.4, Paint()..color = _palette['armorLight']!..colorFilter = ColorFilter.mode(Colors.white.withOpacity(0.7), BlendMode.srcATop));

      final dx = leg.t.dx - leg.k.dx;
      final dy = leg.t.dy - leg.k.dy;
      final len = math.sqrt(dx * dx + dy * dy);
      final nx = -dy / len;
      final ny = dx / len;
      final tipPath = Path()
        ..moveTo(leg.t.dx + nx * 3.5, leg.t.dy + ny * 3.5)
        ..lineTo(leg.t.dx + (dx / len) * 7, leg.t.dy + (dy / len) * 7)
        ..lineTo(leg.t.dx - nx * 3.5, leg.t.dy - ny * 3.5)
        ..close();
      canvas.drawPath(tipPath, Paint()..color = _palette['outline']!);
      canvas.restore();
    }
  }

  void _drawChelicerae(Canvas canvas) {
    final fill = Paint()..color = _palette['armor']!..style = PaintingStyle.fill;
    final stroke = Paint()..color = _palette['outline']!..strokeWidth = 2..style = PaintingStyle.stroke..strokeJoin = StrokeJoin.round;

    final left = Path()
      ..moveTo(44, 76)..cubicTo(38, 76, 30, 78, 26, 86)..cubicTo(22, 94, 26, 103, 30, 106)
      ..cubicTo(28, 99, 30, 93, 34, 90)..cubicTo(38, 96, 36, 104, 34, 108)
      ..cubicTo(40, 102, 42, 93, 40, 86)..cubicTo(44, 84, 46, 80, 44, 76)..close();

    final right = Path()
      ..moveTo(56, 76)..cubicTo(62, 76, 70, 78, 74, 86)..cubicTo(78, 94, 74, 103, 70, 106)
      ..cubicTo(72, 99, 70, 93, 66, 90)..cubicTo(62, 96, 64, 104, 66, 108)
      ..cubicTo(60, 102, 58, 93, 60, 86)..cubicTo(56, 84, 54, 80, 56, 76)..close();

    canvas.drawPath(left, fill); canvas.drawPath(left, stroke);
    canvas.drawPath(right, fill); canvas.drawPath(right, stroke);
  }

  void _drawArmor(Canvas canvas) {
    final armorPath = Path()
      ..moveTo(28, 12)..quadraticBezierTo(50, 5, 72, 12)..lineTo(90, 28)
      ..lineTo(97, 50)..lineTo(90, 72)..lineTo(76, 82)..lineTo(50, 86)
      ..lineTo(24, 82)..lineTo(10, 72)..lineTo(3, 50)..lineTo(10, 28)..close();

    // Mapowanie cx=36%, cy=26% z SVG
    final armorGradient = ui.Gradient.radial(
      const Offset(36, 26), 72,
      [_palette['armorLight']!, _palette['armorDark']!],
      [0.0, 1.0],
    );

    canvas.drawPath(armorPath, Paint()..shader = armorGradient..style = PaintingStyle.fill);
    canvas.drawPath(armorPath, Paint()..color = _palette['outline']!..strokeWidth = 3.5..style = PaintingStyle.stroke..strokeJoin = StrokeJoin.round);

    final detailsPaint = Paint()..color = _palette['armorDark']!..strokeWidth = 1.6..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round;
    canvas.drawPath(Path()..moveTo(30, 12)..quadraticBezierTo(50, 21, 70, 12), detailsPaint..strokeWidth = 1.8);
    canvas.drawPath(Path()..moveTo(10, 72)..lineTo(22, 70)..lineTo(28, 80), detailsPaint);
    canvas.drawPath(Path()..moveTo(90, 72)..lineTo(78, 70)..lineTo(72, 80), detailsPaint);
    canvas.drawPath(Path()..moveTo(42, 82)..lineTo(42, 75)..lineTo(58, 75)..lineTo(58, 82), detailsPaint);
  }

  void _drawVisors(Canvas canvas) {
    final pulseT = (time % 3.2) / 3.2;
    final pulseIntensity = 0.9 + 0.1 * math.sin(pulseT * 2 * math.pi);
    final delayT = ((time - 0.5) % 3.2) / 3.2;
    final pulseIntensityDelay = 0.9 + 0.1 * math.sin(delayT * 2 * math.pi);

    final glowPaint = Paint()
      ..color = _palette['visorGlow']!.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);

    canvas.drawCircle(const Offset(34, 52), 15 * pulseIntensity, glowPaint);
    canvas.drawCircle(const Offset(66, 52), 15 * pulseIntensityDelay, glowPaint);

    final leftVisorGrad = ui.Gradient.radial(const Offset(30, 48), 15, [const Color(0xFFfffaaa), _palette['visor']!], [0.0, 1.0]);
    final rightVisorGrad = ui.Gradient.radial(const Offset(62, 48), 15, [const Color(0xFFfffaaa), _palette['visor']!], [0.0, 1.0]);

    final strokePaint = Paint()..color = _palette['outline']!..strokeWidth = 3..style = PaintingStyle.stroke;

    canvas.drawCircle(const Offset(34, 52), 11.5 * pulseIntensity, Paint()..shader = leftVisorGrad..style = PaintingStyle.fill);
    canvas.drawCircle(const Offset(34, 52), 11.5, strokePaint);
    canvas.drawCircle(const Offset(66, 52), 11.5 * pulseIntensityDelay, Paint()..shader = rightVisorGrad..style = PaintingStyle.fill);
    canvas.drawCircle(const Offset(66, 52), 11.5, strokePaint);

    canvas.drawCircle(const Offset(30, 47.5), 3.2, Paint()..color = Colors.white.withOpacity(0.52));
    canvas.drawCircle(const Offset(62, 47.5), 3.2, Paint()..color = Colors.white.withOpacity(0.52));
  }

  void _drawSensorsAndLED(Canvas canvas) {
    final sensorGlow = Paint()
      ..color = _palette['visor']!.withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
    final sensorStroke = Paint()..color = _palette['outline']!..strokeWidth = 2.2..style = PaintingStyle.stroke;

    final sensors = [
      {'p': const Offset(23, 36), 'r': 3.5},
      {'p': const Offset(38, 31), 'r': 4.5},
      {'p': const Offset(62, 31), 'r': 4.5},
      {'p': const Offset(77, 36), 'r': 3.5},
    ];

    for (var s in sensors) {
      canvas.drawCircle(s['p'] as Offset, s['r'] as double, sensorGlow);
      canvas.drawCircle(s['p'] as Offset, s['r'] as double, Paint()..color = _palette['visor']!);
      canvas.drawCircle(s['p'] as Offset, s['r'] as double, sensorStroke);
    }

    final ledT = (time % 2.4) / 2.4;
    final ledAlpha = (math.sin(ledT * 2 * math.pi) + 1) / 2.0;

    final ledGlow = Paint()
      ..color = _palette['accent']!.withOpacity(0.2 + 0.8 * ledAlpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    canvas.drawCircle(const Offset(17, 50), 2.2, ledGlow);
    canvas.drawCircle(const Offset(17, 50), 2.2, Paint()..color = _palette['accent']!);
  }

  @override
  bool shouldRepaint(covariant _FuzziPainter oldDelegate) => true;
}

class _LegDef {
  final Offset r, c1, k, c2, t;
  final int i;
  _LegDef(this.r, this.c1, this.k, this.c2, this.t, this.i);
}
