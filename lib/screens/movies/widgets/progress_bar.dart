// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      width: 50,
      height: 50,
      child: RadianPercentWidget(
        percent: 0.75,
        backgroundColor: Color.fromARGB(255, 8, 28, 34),
        freeLineColor: Color.fromARGB(255, 30, 66, 40),
        lineColor: Color.fromARGB(255, 33, 208, 123),
        lineWidth: 3,
        child: Text(
          '75%',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ));
  }
}

class RadianPercentWidget extends StatelessWidget {
  final Widget child;

  final double percent;
  final Color backgroundColor;
  final Color lineColor;
  final Color freeLineColor;
  final double lineWidth;

  const RadianPercentWidget({
    Key? key,
    required this.child,
    required this.percent,
    required this.backgroundColor,
    required this.lineColor,
    required this.freeLineColor,
    required this.lineWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
            painter: MyPainter(
          backgroundColor: backgroundColor,
          freeLineColor: freeLineColor,
          fillLineColor: lineColor,
          lineWidth: lineWidth,
          percent: percent,
        )),
        Center(child: child),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color backgroundColor;
  final Color fillLineColor;
  final Color freeLineColor;
  final double lineWidth;

  MyPainter({
    required this.percent,
    required this.backgroundColor,
    required this.freeLineColor,
    required this.fillLineColor,
    required this.lineWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcRect = calculateArcsRect(size);
    drawBackground(canvas, size);
    drawFreeLine(canvas, arcRect);
    drawFillLine(canvas, arcRect);
  }

  void drawFillLine(Canvas canvas, Rect arcRect) {
    final paint = Paint()
      ..color = fillLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2 * percent,
      false,
      paint,
    );
  }

  void drawFreeLine(Canvas canvas, Rect arcRect) {
    final paint = Paint()
      ..color = freeLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    const int linesMargin = 4;
    final double offset = lineWidth / 2 + linesMargin;
    final arcRect = Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
