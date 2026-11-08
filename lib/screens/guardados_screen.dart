import 'package:flutter/material.dart';
import '../models/carrera.dart';
import '../services/api_service.dart';
import '../services/guardados_service.dart';
import '../widgets/barra_navegacion.dart';
import '../widgets/fondo_puntos.dart';

class GuardadosScreen extends StatefulWidget {
  const GuardadosScreen({super.key});

  @override
  State<GuardadosScreen> createState() => _GuardadosScreenState();
}

class _GuardadosScreenState extends State<GuardadosScreen> {
  static const Color azul = Color(0xFF24416B);
  static const Color amarillo = Color(0xFFFFC107);
  static const Color crema = Color(0xFFFFF0D6);

  List<Carrera> _guardadas = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  // Lee los nombres guardados y busca esas carreras en la lista
  Future<void> _cargar() async {
    final nombres = await GuardadosService.obtener();
    final lista = carreras.where((c) => nombres.contains(c.nombre)).toList();

    if (!mounted) return;
    setState(() {
      _guardadas = lista;
      _cargando = false;
    });
  }

  Future<void> _eliminar(Carrera carrera) async {
    await GuardadosService.eliminar(carrera.nombre);
    _cargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FondoPuntos(
        child: SafeArea(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: Image.asset(
                        'assets/images/icon_atras.png',
                        width: 28,
                        height: 28,
                        errorBuilder: (context, error, stack) =>
                            const Icon(Icons.arrow_back, color: azul),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Mis carreras guardadas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: azul,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Lista
              Expanded(
                child: _cargando
                    ? const Center(
                        child: CircularProgressIndicator(color: amarillo),
                      )
                    : _guardadas.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'Aún no has guardado ninguna carrera.\nHaz el test y guarda tu resultado.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: azul,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                            itemCount: _guardadas.length,
                            itemBuilder: (context, i) => _tarjeta(_guardadas[i]),
                          ),
              ),

              const BarraNavegacion(indice: -1),
            ],
          ),
        ),
      ),
    );
  }

  // Tarjeta de una carrera guardada
  Widget _tarjeta(Carrera carrera) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: crema,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: amarillo, width: 2),
      ),
      child: Row(
        children: [
          // Pokémon 
          SizedBox(
            width: 70,
            height: 70,
            child: FutureBuilder<PokemonInfo>(
              future: ApiService.obtenerPokemon(carrera.mentor),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(color: amarillo),
                  );
                }
                if (snapshot.hasError) {
                  return const Icon(Icons.error_outline, color: azul);
                }
                return Image.network(
                  snapshot.data!.imagen,
                  errorBuilder: (context, error, stack) => const Icon(
                    Icons.catching_pokemon,
                    size: 40,
                    color: amarillo,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carrera.nombre,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: azul,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  carrera.descripcion,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: azul,
                  ),
                ),
              ],
            ),
          ),

          // Boton borrar
          IconButton(
            onPressed: () => _eliminar(carrera),
            icon: Image.asset(
              'assets/images/icon_borrar.png',
              width: 28,
              height: 28,
              errorBuilder: (context, error, stack) =>
                  const Icon(Icons.delete_outline, color: azul),
            ),
          ),
        ],
      ),
    );
  }
}