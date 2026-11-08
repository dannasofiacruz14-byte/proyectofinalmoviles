import 'dart:math';

class Carrera {
  final String nombre;
  final String descripcion; 
  final String imagen; 
  final String pokemon; 
  final String mentor;
  final String consejo;
  final int categoria; 
  final String wikipedia; 

  const Carrera({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.pokemon,
    required this.mentor,
    required this.consejo,
    required this.categoria,
    required this.wikipedia,
  });
}

// Lista de carreras 
const List<Carrera> carreras = [
  Carrera(
    nombre: 'Ingeniería de Software',
    descripcion: 'Crea soluciones a través del código.',
    pokemon: 'pikachu',
    mentor: 'jolteon',
    imagen: 'assets/images/carrera_software.png',
    categoria: 1,
    wikipedia: 'Ingeniería_de_software',
    consejo:
        'Te apasiona la tecnología, el aprendizaje constante y resolver problemas. Ingeniería de Software es una carrera perfecta para ti, ya que combina creatividad, lógica y la creación de soluciones innovadoras.',
  ),
  Carrera(
    nombre: 'Diseño gráfico',
    descripcion: 'Da vida a tus ideas con creatividad.',
    pokemon: 'eevee',
    mentor: 'eevee',
    imagen: 'assets/images/carrera_diseno.png',
    categoria: 0,
    wikipedia: 'Diseño_gráfico',
    consejo:
        'Tienes una mente creativa y un gran ojo para los detalles. Diseño gráfico te permite convertir tus ideas en imágenes que comunican, emocionan y dejan huella.',
  ),
  Carrera(
    nombre: 'Marketing Digital',
    descripcion: 'Conecta, comunica y crea estrategias.',
    pokemon: 'gengar',
    mentor: 'gengar',
    imagen: 'assets/images/carrera_marketing.png',
    categoria: 2,
    wikipedia: 'Marketing_digital',
    consejo:
        'Se te da conectar con las personas y contar historias que importan. Marketing Digital une creatividad y estrategia para llegar a más gente.',
  ),
  Carrera(
    nombre: 'UX/UI',
    descripcion: 'Diseña experiencias increíbles.',
    pokemon: 'jigglypuff',
    mentor: 'jigglypuff',
    imagen: 'assets/images/carrera_uxui.png',
    categoria: 0,
    wikipedia: 'Experiencia_de_usuario',
    consejo:
        'Te gusta crear cosas que la gente disfruta usar. UX/UI combina creatividad y empatía para diseñar experiencias claras, bonitas y fáciles de usar.',
  ),
  Carrera(
    nombre: 'Animación',
    descripcion: 'Da movimiento a tus historias.',
    pokemon: 'squirtle',
    mentor: 'squirtle',
    imagen: 'assets/images/carrera_animacion.png',
    categoria: 3,
    wikipedia: 'Animación',
    consejo:
        'Te encanta imaginar mundos y personajes y darles vida. Animación te permite combinar arte, creatividad y tecnología para contar historias llenas de movimiento y emoción.',
  ),
  Carrera(
    nombre: 'Derecho',
    descripcion: 'Defiende la justicia y los derechos de las personas.',
    pokemon: 'charmander',
    mentor: 'charmander',
    imagen: 'assets/images/carrera_derecho.png',
    categoria: 2,
    wikipedia: 'Derecho',
    consejo:
        'Tienes capacidad para analizar, argumentar y defender lo que es justo. Derecho te prepara para entender las leyes, ayudar a resolver conflictos y proteger los derechos de las personas.',
  ),
];

// Calcula la carrera según las respuestas 
Carrera calcularResultado(List<int> respuestas) {
  final conteo = [0, 0, 0, 0];
  for (int r in respuestas) {
    conteo[r]++;
  }


  int maximo = 0;
  for (int c in conteo) {
    if (c > maximo) maximo = c;
  }


  final empatadas = <int>[];
  for (int i = 0; i < conteo.length; i++) {
    if (conteo[i] == maximo) empatadas.add(i);
  }
  final azar = Random();
  final categoria = empatadas[azar.nextInt(empatadas.length)];

  final posibles = carreras.where((c) => c.categoria == categoria).toList();
  return posibles[azar.nextInt(posibles.length)];
}