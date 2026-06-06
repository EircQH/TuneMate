import 'package:flutter/material.dart';
import '../models/chord.dart';

class ChordDiagram extends StatelessWidget {
  final Chord chord;
  final double size;

  const ChordDiagram({
    super.key,
    required this.chord,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 1.5),
      painter: _ChordDiagramPainter(
        chord: chord,
        primaryColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
      ),
    );
  }
}

class _ChordDiagramPainter extends CustomPainter {
  final Chord chord;
  final Color primaryColor;
  final Color textColor;

  _ChordDiagramPainter({
    required this.chord,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final fillPaint = Paint()..style = PaintingStyle.fill;

    const int numStrings = 6;
    // 动态计算品格数：4品为主流，高把位复杂和弦用5品
    final activeFrets = chord.frets.where((f) => f > 0).toList();
    final fretSpan = activeFrets.isEmpty ? 4 : activeFrets.reduce((a, b) => a > b ? a : b) - chord.baseFret + 1;
    final int numFrets = fretSpan > 4 ? 5 : 4;
    final double stringSpacing = size.width / (numStrings + 1);
    final double fretSpacing = (size.height - 60) / (numFrets + 1);
    final double startX = stringSpacing;
    final double startY = 50;

    // 绘制弦（竖线）
    paint.color = Colors.grey.shade600;
    for (int i = 0; i < numStrings; i++) {
      final x = startX + i * stringSpacing;
      canvas.drawLine(
        Offset(x, startY),
        Offset(x, startY + numFrets * fretSpacing),
        paint,
      );
    }

    // 绘制品（横线）
    for (int i = 0; i <= numFrets; i++) {
      final y = startY + i * fretSpacing;
      paint.strokeWidth = i == 0 ? 2.5 : 1;
      paint.color = Colors.grey.shade600;
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + (numStrings - 1) * stringSpacing, y),
        paint,
      );
    }

    // 绘制品位数字
    if (chord.baseFret > 1) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${chord.baseFret}fr',
          style: TextStyle(color: textColor, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(startX - textPainter.width - 4, startY - 8));
    }

    // 绘制按弦点和X/O标记
    for (int i = 0; i < chord.frets.length; i++) {
      final stringIndex = i;
      final fret = chord.frets[i];
      final finger = chord.fingers[i];
      final x = startX + stringIndex * stringSpacing;

      if (fret == -1 || fret == 0) {
        // 不绘制空弦和闷音标记
      } else {
        final fretIndex = fret - chord.baseFret + 1;
        final y = startY + (fretIndex - 0.5) * fretSpacing;

        fillPaint.color = primaryColor;
        canvas.drawCircle(Offset(x, y), stringSpacing * 0.35, fillPaint);

        if (finger > 0) {
          final textPainter = TextPainter(
            text: TextSpan(
              text: '$finger',
              style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(x - textPainter.width / 2, y - textPainter.height / 2),
          );
        }
      }
    }

    // 绘制和弦名称
    final namePainter = TextPainter(
      text: TextSpan(
        text: chord.name,
        style: TextStyle(
          color: primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    namePainter.layout();
    namePainter.paint(
      canvas,
      Offset((size.width - namePainter.width) / 2, 10),
    );
  }

  void _drawX(Canvas canvas, double x, double y, double size, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x - size, y - size), Offset(x + size, y + size), paint);
    canvas.drawLine(Offset(x - size, y + size), Offset(x + size, y - size), paint);
  }

  void _drawO(Canvas canvas, double x, double y, double radius, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  @override
  bool shouldRepaint(covariant _ChordDiagramPainter oldDelegate) =>
      oldDelegate.chord != chord ||
      oldDelegate.primaryColor != primaryColor ||
      oldDelegate.textColor != textColor;
}
