import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/test_screen.dart';
import '../screens/pokedex_screen.dart';


class BarraNavegacion extends StatelessWidget {
  final int indice; // pestaña activa: 0 Inicio, 1 Test, 2 PokéDex
  final Color color;

  const BarraNavegacion({
    super.key,
    required this.indice,
    this.color = const Color(0xFFFFF0D6),
  });

  static const Color azul = Color(0xFF24416B);

  void _ir(BuildContext context, int destino) {
    if (destino == indice) return; // ya está en esa pestaña

    Widget pantalla;
    if (destino == 0) {
      pantalla = const HomeScreen();
    } else if (destino == 1) {
      pantalla = const TestScreen();
    } else {
      pantalla = const PokedexScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pantalla),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFFFC107), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _item(context, 0, 'assets/images/icon_inicio.png', 'Inicio'),
          _item(context, 1, 'assets/images/icon_test.png', 'Test'),
          _item(context, 2, 'assets/images/icon_pokedex.png', 'PokéDex'),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, int index, String imagen, String texto) {
    return InkWell(
      onTap: () => _ir(context, index),
      child: Column(
        children: [
          Image.asset(imagen, height: 40),
          Text(
            texto,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: indice == index ? FontWeight.w800 : FontWeight.w600,
              color: azul,
            ),
          ),
        ],
      ),
    );
  }
}