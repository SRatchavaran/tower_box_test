import 'package:flutter/material.dart';

class DrawTriangleStroke extends CustomPainter {
  Paint? painter;
  bool isLeftMain = true;

  DrawTriangleStroke({bool isLeft = true}) {
    painter = Paint()
      ..color = Color(0XFF707070)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    isLeftMain = isLeft;
  }

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    var path = Path();
    if (isLeftMain) {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.width);
      path.close();
    } else {
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.close();
    }

    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawTriangleFill extends CustomPainter {
  Paint? painter;

  bool isLeftMain = true;

  DrawTriangleFill({bool isLeft = true}) {
    painter = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    isLeftMain = isLeft;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    if (isLeftMain) {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.width);
      path.close();
    } else {
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.close();
    }

    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawDiamondFill extends CustomPainter {
  Paint? painter;

  DrawDiamondFill() {
    painter = Paint()
      ..color = const Color(0XFFD27AFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(0, size.width / 2);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.width / 2);
    path.lineTo(size.width / 2, size.width);
    path.close();

    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawDiamondStroke extends CustomPainter {
  Paint? painter;

  DrawDiamondStroke() {
    painter = Paint()
      ..color = const Color(0XFF707070)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(0, size.width / 2);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.width / 2);
    path.lineTo(size.width / 2, size.width);
    path.close();

    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
