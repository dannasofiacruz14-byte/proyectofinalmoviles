import 'package:flutter/material.dart';
import '../widgets/barra_navegacion.dart';
import 'test_screen.dart';
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  static const Color azul = Color(0xFF24416B);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1D8),
      body: Stack(
        children: [
          // Pokébolas de fondo
          _pokebola(top: -35, left: -35),
          _pokebola(top: 110, right: -50),
          _pokebola(top: 350, right: -50),
          _pokebola(bottom: 200, left: -35),
          _pokebola(bottom: -50, right: -60),
 
          // Contenido
          SafeArea(
            child: Column(
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/images/pokemon_logo.png',
                    height: 85,
                  ),
                ),
 
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 200),
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const Text(
                              '¡Descubre tu\nprofesión ideal!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: azul,
                              ),
                            ),
                            const SizedBox(height: 28),
                            const Text(
                              'Responde unas preguntas sencillas y descubre qué carrera se adapta a ti con la ayuda de un Pokémon mentor.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: azul,
                              ),
                            ),
                            const SizedBox(height: 44),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TestScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE54848),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 36, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 6,
                              ),
                              child: const Text(
                                'Iniciar test vocacional',
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
 
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -200,
                      child: Image.asset(
                        'assets/images/pikachu_grad.png',
                        height: 210,
                      ),
                    ),
                    const BarraNavegacion(
                      indice: 0,
                      color: Color(0xFFFFF9EE),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _pokebola({double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Image.asset('assets/images/pokebol.png', width: 120, height: 120),
    );
  }
}