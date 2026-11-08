import 'package:flutter/material.dart';
import '../screens/guardados_screen.dart';

class BotonGuardados extends StatelessWidget {
  const BotonGuardados({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GuardadosScreen()),
        );
      },
      child: Image.asset(
        'assets/images/icon_guardados.png',
        height: 35,
      ),
    );
  }
}