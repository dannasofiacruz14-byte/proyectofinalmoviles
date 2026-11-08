import 'package:shared_preferences/shared_preferences.dart';


class GuardadosService {
  static const String _clave = 'carreras_guardadas';


  static Future<List<String>> obtener() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_clave) ?? [];
  }

  // Guarda una carrera Devuelve false si ya estaba guardada
  static Future<bool> guardar(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    final lista = List<String>.from(prefs.getStringList(_clave) ?? []);

    if (lista.contains(nombre)) return false;

    lista.add(nombre);
    await prefs.setStringList(_clave, lista);
    return true;
  }


  static Future<void> eliminar(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    final lista = List<String>.from(prefs.getStringList(_clave) ?? []);

    lista.remove(nombre);
    await prefs.setStringList(_clave, lista);
  }
}