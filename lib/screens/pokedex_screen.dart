import 'package:flutter/material.dart';
import '../models/carrera.dart';
import '../services/api_service.dart';
import '../widgets/barra_navegacion.dart';
import '../widgets/fondo_puntos.dart';
import '../widgets/boton_guardados.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  static const Color azul = Color(0xFF24416B);
  static const Color amarillo = Color(0xFFFFC107);
  static const Color crema = Color(0xFFFFF0D6);

  String _busqueda = '';

  // Al tocar una carrera muestra su resumen
  void _verDetalle(Carrera carrera) {
    final resumen = ApiService.obtenerResumen(carrera.wikipedia);

    showModalBottomSheet(
      context: context,
      backgroundColor: crema,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                carrera.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: azul,
                ),
              ),
              const SizedBox(height: 14),
              Flexible(
                child: SingleChildScrollView(
                  child: FutureBuilder<String>(
                    future: resumen,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(color: amarillo),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text('No se pudo cargar la información.');
                      }
                      return Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: azul,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Fuente: Wikipedia',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    
    // Carreras que coinciden con lo que se escribió en el buscador
    final lista = carreras
        .where((c) => c.nombre.toLowerCase().contains(_busqueda.toLowerCase()))
        .toList();

    return Scaffold(
      body: FondoPuntos(
        child: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, right: 16),
                  child: BotonGuardados(),
                ),
              ),
              const SizedBox(height: 4),

              const Text(
                'Pokédex de Carreras',
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: azul,
                ),
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Descubre todas las profesiones y encuentra la que más se adapte a ti.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: azul,
                  ),
                ),
              ),



              // Buscador
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: TextField(
                  onChanged: (texto) {
                    setState(() {
                      _busqueda = texto;
                    });
                  },
                  style: const TextStyle(fontFamily: 'Nunito', color: azul),
                  decoration: InputDecoration(
                    hintText: 'Buscar una carrera...',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'assets/images/icon_lupa.webp',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stack) =>
                            const Icon(Icons.search, color: azul),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF0E2C8),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: amarillo, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: amarillo, width: 2),
                    ),
                  ),
                ),
              ),

         
              Expanded(
                child: lista.isEmpty
                    ? const Center(
                        child: Text(
                          'No encontramos esa carrera',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: azul,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: lista.length,
                        itemBuilder: (context, i) => _tarjeta(lista[i]),
                      ),
              ),

              const BarraNavegacion(indice: 2),
            ],
          ),
        ),
      ),
    );
  }


  Widget _tarjeta(Carrera carrera) {
    return GestureDetector(
      onTap: () => _verDetalle(carrera),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: crema,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: amarillo, width: 2),
        ),
        child: Column(
          children: [
            Expanded(
              // Tu imagen; si todavía no existe, muestra el Pokémon de PokéAPI
              child: Image.asset(
                carrera.imagen,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) => _imagenApi(carrera),
              ),
            ),
            Text(
              carrera.nombre,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: azul,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              carrera.descripcion,
              textAlign: TextAlign.center,
              maxLines: 2,
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
    );
  }

  // Imagen de respaldo
  Widget _imagenApi(Carrera carrera) {
    return FutureBuilder<PokemonInfo>(
      future: ApiService.obtenerPokemon(carrera.pokemon),
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
            size: 50,
            color: amarillo,
          ),
        );
      },
    );
  }
}