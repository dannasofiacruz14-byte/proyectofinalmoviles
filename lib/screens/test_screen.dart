import 'package:flutter/material.dart';
import '../models/carrera.dart';
import '../widgets/barra_navegacion.dart';
import '../widgets/fondo_puntos.dart';
import '../widgets/boton_guardados.dart';
import 'resultado_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  static const Color azul = Color(0xFF24416B);
  static const Color amarillo = Color(0xFFFFC107);

  int _preguntaActual = 0; 
  int? _seleccion; 
  final List<int> _respuestas = []; // 


  final List<String> _iconos = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
  ];

  final List<String> _titulos = [
    '¿Qué actividad disfrutas más en tu tiempo libre?',
    '¿En qué tipo de proyecto te gustaría trabajar?',
    '¿Cómo prefieres trabajar?',
    '¿Qué te gustaría lograr en el futuro?',
  ];

  final List<List<String>> _opciones = [
    ['Crear y diseñar', 'Resolver desafíos', 'Ayudar a los demás', 'Explorar y descubrir'],
    ['Diseñar algo nuevo', 'Resolver un problema difícil', 'Apoyar a otras personas', 'Investigar algo desconocido'],
    ['Con libertad para crear', 'Con lógica y planeación', 'En equipo ayudando', 'Probando cosas nuevas'],
    ['Dejar mi huella creativa', 'Crear soluciones inteligentes', 'Mejorar la vida de otros', 'Descubrir nuevas ideas'],
  ];

  void _siguiente() {
    if (_seleccion == null) return; // no avanza si no eligió nada

    _respuestas.add(_seleccion!);

    if (_preguntaActual < _titulos.length - 1) {
      setState(() {
        _preguntaActual++;
        _seleccion = null;
      });
    } else {

      // Última pregunt calcular la carrera y mostrar el resultado
      final resultado = calcularResultado(_respuestas);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadoScreen(carrera: resultado),
        ),
      );
    }
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pregunta ${_preguntaActual + 1} de ${_titulos.length}',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: azul,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Barra de progreso
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: (_preguntaActual + 1) / _titulos.length,
                          minHeight: 30,
                          backgroundColor: const Color(0xFFEFE0C6),
                          color: const Color(0xFFFFC800),
                        ),
                      ),
                      const SizedBox(height: 20),

                  
                  
                      Center(
                        child: Text(
                          _titulos[_preguntaActual],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Fredoka',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: azul,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Las 4 opciones
                      _opcion(0),
                      _opcion(1),
                      _opcion(2),
                      _opcion(3),
                    ],
                  ),
                ),
              ),

              // Botón Siguiente 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: _siguiente,
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
                  child: Text(
                    _preguntaActual == _titulos.length - 1
                        ? 'Ver resultado'
                        : 'Siguiente',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Barra de navegación
              const BarraNavegacion(indice: 1),
            ],
          ),
        ),
      ),
    );
  }



  Widget _opcion(int index) {
    final bool elegida = _seleccion == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _seleccion = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0D6),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: amarillo, width: elegida ? 3 : 1),
        ),
        child: Row(
          children: [
      
      
            Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFE49A),
              ),
              child: Image.asset(_iconos[index]),
            ),

            // Texto
            Expanded(
              child: Text(
                _opciones[_preguntaActual][index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: azul,
                ),
              ),
            ),

        
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: elegida ? amarillo : Colors.transparent,
                border: Border.all(color: const Color(0xFFD4A514), width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}