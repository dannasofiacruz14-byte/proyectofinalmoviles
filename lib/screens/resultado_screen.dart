import 'package:flutter/material.dart';
import '../models/carrera.dart';
import '../services/api_service.dart';
import '../services/guardados_service.dart';
import '../widgets/barra_navegacion.dart';
import '../widgets/fondo_puntos.dart';
import '../widgets/boton_guardados.dart';
import 'guardados_screen.dart';

class ResultadoScreen extends StatelessWidget {
  final Carrera carrera;

  const ResultadoScreen({super.key, required this.carrera});

  static const Color azul = Color(0xFF24416B);
  static const Color amarillo = Color(0xFFFFC107);
  static const Color crema = Color(0xFFFFF0D6);

  // Guarda la carrera en el dispositivo
  Future<void> _guardar(BuildContext context) async {
    final esNueva = await GuardadosService.guardar(carrera.nombre);

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          esNueva ? '¡Carrera guardada!' : 'Ya tenías guardada esta carrera',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FondoPuntos(
        child: SafeArea(
          child: Column(
            children: [
            
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Image.asset(
                        'assets/images/pokemon_logo.png',
                        height: 70,
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 16,
                      child: BotonGuardados(),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

         
                      Text(
                        '¡Tu carrera ideal es\n${carrera.nombre}!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: azul,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Tarjeta del Pokémon mentor 
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: crema,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: amarillo, width: 2),
                        ),
                        child: FutureBuilder<PokemonInfo>(
                          future: ApiService.obtenerPokemon(carrera.mentor),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const SizedBox(
                                height: 170,
                                child: Center(
                                  child: CircularProgressIndicator(
                                      color: amarillo),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return const SizedBox(
                                height: 170,
                                child: Center(
                                  child: Text('No se pudo cargar el Pokémon'),
                                ),
                              );
                            }
                            final pokemon = snapshot.data!;
                            return Column(
                              children: [
                                Image.network(
                                  pokemon.imagen,
                                  height: 130,
                                  loadingBuilder: (context, child, progreso) {
                                    if (progreso == null) return child;
                                    return const SizedBox(
                                      height: 130,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            color: amarillo),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stack) =>
                                      const SizedBox(
                                    height: 130,
                                    child: Center(
                                      child: Icon(Icons.catching_pokemon,
                                          size: 70, color: amarillo),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE082),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    pokemon.nombre,
                                    style: const TextStyle(
                                      fontFamily: 'Fredoka',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 14),

  
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 22),
                            padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                            decoration: BoxDecoration(
                              color: crema,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: amarillo, width: 2),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Nuestro consejo para ti',
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: azul,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  carrera.consejo,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: azul,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 4,
                            child: Image.asset(
                              'assets/images/icon_foco.png',
                              height: 48,
                              errorBuilder: (context, error, stack) =>
                                  const Icon(Icons.lightbulb,
                                      size: 48, color: amarillo),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

  
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 6),
                child: ElevatedButton(
                  onPressed: () => _guardar(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE54848),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 6,
                  ),
                  child: const Text(
                    'Guardar resultados',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Botón Ver guardados
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GuardadosScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: crema,
                    foregroundColor: azul,
                    side: const BorderSide(color: amarillo, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Ver mis guardados',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const BarraNavegacion(indice: 1),
            ],
          ),
        ),
      ),
    );
  }
}