import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonInfo {
  final String nombre;
  final String imagen;

  PokemonInfo({required this.nombre, required this.imagen});
}

class ApiService {
  // Guarda los Pokémon ya pedidos para no repetir la petición
  static final Map<String, Future<PokemonInfo>> _guardados = {};


  static Future<PokemonInfo> obtenerPokemon(String nombre) {
    return _guardados.putIfAbsent(nombre, () => _pedirPokemon(nombre));
  }

  static Future<PokemonInfo> _pedirPokemon(String nombre) async {
    try {
      final url = Uri.https('pokeapi.co', '/api/v2/pokemon/$nombre');
      final respuesta = await http.get(url);

      if (respuesta.statusCode != 200) {
        throw Exception('No se pudo cargar el Pokémon');
      }

      final datos = jsonDecode(respuesta.body);
      final String nombreApi = datos['name'];
      final String imagen =
          datos['sprites']['other']['official-artwork']['front_default'];

      return PokemonInfo(
        nombre: nombreApi[0].toUpperCase() + nombreApi.substring(1),
        imagen: imagen,
      );
    } catch (e) {
      _guardados.remove(nombre); 
      rethrow;
    }
  }

  // API 2
  static Future<String> obtenerResumen(String titulo) async {
    final url = Uri.https('es.wikipedia.org', '/api/rest_v1/page/summary/$titulo');
    final respuesta = await http.get(url);

    if (respuesta.statusCode != 200) {
      throw Exception('No se pudo cargar la información');
    }

    final datos = jsonDecode(respuesta.body);
    return datos['extract'];
  }
}