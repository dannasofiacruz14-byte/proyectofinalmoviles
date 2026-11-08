import 'package:flutter/material.dart';


class FondoPuntos extends StatelessWidget {
  final Widget child;

  const FondoPuntos({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFFFFCEB),
      child: CustomPaint(
        painter: _PuntosPainter(),
        child: child,
      ),
    );
  }
}

class _PuntosPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pincel = Paint()..color = const Color(0xFFF3EBD0);
    for (double x = 15; x < size.width; x += 30) {
      for (double y = 15; y < size.height; y += 30) {
        canvas.drawCircle(Offset(x, y), 3, pincel);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}