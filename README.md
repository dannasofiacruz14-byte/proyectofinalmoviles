Pokémon Career Test

https://dannasofiacruz14-byte.github.io/proyectofinalmoviles/

Aplicación móvil hecha con Flutter que ayuda a descubrir qué carrera se adapta mejor a cada persona. El usuario responde un test vocacional de 4 preguntas y la app le muestra su carrera ideal, acompañada de un Pokémon mentor y un consejo personalizado.

Proyecto académico desarrollado por Danna Sofia Cruz.

¿Qué es y para qué sirve?

Muchas personas no saben qué carrera estudiar. Pokémon Career Test convierte esa decisión en una experiencia divertida: con preguntas sencillas sobre gustos y forma de trabajar, la app sugiere una carrera y explica por qué encaja con la persona. Además incluye una Pokédex de carreras para explorar todas las opciones.

Público objetivo: estudiantes de bachillerato y jóvenes que están eligiendo qué estudiar.

Funcionalidades
Test vocacional de 4 preguntas con barra de progreso y 4 opciones por pregunta.
Resultado personalizado: carrera ideal, Pokémon mentor y un consejo.
Pokédex de carreras con buscador en tiempo real.
Detalle de cada carrera con un resumen tomado de Wikipedia.
Guardar resultados en el dispositivo y consultarlos en la pantalla de guardados.
Eliminar carreras guardadas.
Navegación con barra inferior personalizada entre Inicio, Test y Pokédex.
Pantallas
Inicio: bienvenida y botón para iniciar el test.
Test: preguntas con opciones de respuesta.
Resultado: carrera ideal, Pokémon mentor y consejo.
Pokédex de carreras: listado, buscador y detalle de cada carrera.
Guardados: carreras que el usuario guardó.
Tecnologías
Flutter y Dart
Paquete http para consumir APIs
Paquete shared_preferences para guardar datos en el dispositivo
Paquete device_preview para probar la interfaz en distintos dispositivos
Tipografías Fredoka y Nunito (Google Fonts)
APIs utilizadas
API	Para qué se usa
PokéAPI	Nombre e imagen del Pokémon mentor (pantallas de Resultado y Guardados).
Wikipedia REST API	Resumen en español de cada carrera, al tocar una tarjeta de la Pokédex.
Cómo funciona el resultado

Cada opción de respuesta pertenece a una categoría: crear, resolver, ayudar o explorar. Al terminar el test, la app cuenta cuál categoría se eligió más veces. Si hay empate, o si la categoría tiene varias carreras, elige una al azar entre las posibles.

Estructura del proyecto
lib/
├── main.dart
├── models/
│   └── carrera.dart            # Modelo Carrera, lista de carreras y cálculo del resultado
├── screens/
│   ├── home_screen.dart        # Inicio
│   ├── test_screen.dart        # Test vocacional
│   ├── resultado_screen.dart   # Resultado
│   ├── pokedex_screen.dart     # Pokédex de carreras
│   └── guardados_screen.dart   # Carreras guardadas
├── services/
│   ├── api_service.dart        # Llamadas a PokéAPI y Wikipedia
│   └── guardados_service.dart  # Guardado local con shared_preferences
└── widgets/
    ├── barra_navegacion.dart   # Barra inferior personalizada
    ├── boton_guardados.dart    # Ícono para ir a guardados
    └── fondo_puntos.dart       # Fondo con puntitos
assets/
├── fonts/                      # Fredoka y Nunito
└── images/                     # Logo, íconos e ilustraciones
Cómo ejecutar el proyecto
Requisitos
Flutter SDK instalado
Un editor como VS Code o Android Studio
Conexión a internet (la app consulta APIs)
Pasos
bash
# 1. Clonar el repositorio
git clone https://github.com/TU_USUARIO/pokemon-career-test.git
cd pokemon-career-test

# 2. Instalar las dependencias
flutter pub get

# 3. Ejecutar la app (por ejemplo en Chrome)
flutter run -d chrome
Manual de uso
Abre la app y toca "Iniciar test vocacional".
Elige una respuesta en cada pregunta y toca "Siguiente". Debes elegir una opción para avanzar.
En la última pregunta toca "Ver resultado" para conocer tu carrera ideal, tu Pokémon mentor y tu consejo.
Toca "Guardar resultados" para guardar la carrera en tu dispositivo.
Toca "Ver mis guardados" (o el ícono de marcador, arriba a la derecha) para ver las carreras guardadas. Con la papelera puedes quitar una.
En la Pokédex puedes buscar una carrera por nombre y tocar su tarjeta para leer un resumen.
Usa la barra inferior para moverte entre Inicio, Test y Pokédex.

Autor
Danna Sofia Cruz Proyecto académico de Flutter.