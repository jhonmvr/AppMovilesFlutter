import 'dart:io';

/// Clase que representa a un estudiante y sus calificaciones.
class Estudiante {
  String nombre;
  Map<String, double> calificaciones; // Mapa con asignatura y calificación.

  Estudiante(this.nombre, this.calificaciones);

  /// Método que calcula el promedio de las calificaciones del estudiante.
  double calcularPromedio() {
    double suma = calificaciones.values.fold(0, (total, calificacion) => total + calificacion);
    return suma / calificaciones.length;
  }

  @override
  String toString() {
    return 'Nombre: $nombre, Calificaciones: $calificaciones, Promedio: ${calcularPromedio().toStringAsFixed(2)}';
  }
}

/// Clase que representa la gestión de calificaciones de varios estudiantes.
class GestionCalificaciones {
  List<Estudiante> estudiantes = [];

  /// Método para agregar un nuevo estudiante y sus calificaciones.
  void agregarEstudiante() {
    print('Ingrese el nombre del estudiante:');
    String nombre = stdin.readLineSync()!;

    Map<String, double> calificaciones = {};
    bool continuar = true;

    // Bucle para añadir asignaturas y calificaciones
    while (continuar) {
      print('Ingrese el nombre de la asignatura:');
      String asignatura = stdin.readLineSync()!;
      double calificacion = _leerDouble('Ingrese la calificación para $asignatura:');

      calificaciones[asignatura] = calificacion;

      print('¿Desea agregar otra asignatura? (s/n):');
      continuar = stdin.readLineSync()!.toLowerCase() == 's';
    }

    estudiantes.add(Estudiante(nombre, calificaciones));
    print('Estudiante agregado exitosamente.');
  }

  /// Método para calcular y mostrar el promedio de calificaciones de cada estudiante.
  void mostrarPromedioEstudiantes() {
    if (estudiantes.isEmpty) {
      print('No hay estudiantes registrados.');
      return;
    }
    
    estudiantes.forEach((estudiante) {
      print('Estudiante: ${estudiante.nombre}, Promedio: ${estudiante.calcularPromedio().toStringAsFixed(2)}');
    });
  }

  /// Método para determinar y mostrar la calificación más alta y más baja para cada asignatura.
  void mostrarCalificacionesExtremas() {
    if (estudiantes.isEmpty) {
      print('No hay estudiantes registrados.');
      return;
    }

    Map<String, List<double>> calificacionesPorAsignatura = {};

    // Recolecta todas las calificaciones de cada asignatura
    for (var estudiante in estudiantes) {
      estudiante.calificaciones.forEach((asignatura, calificacion) {
        calificacionesPorAsignatura.putIfAbsent(asignatura, () => []);
        calificacionesPorAsignatura[asignatura]!.add(calificacion);
      });
    }

    // Muestra la calificación más alta y más baja para cada asignatura
    calificacionesPorAsignatura.forEach((asignatura, calificaciones) {
      double maxCalificacion = calificaciones.reduce((a, b) => a > b ? a : b);
      double minCalificacion = calificaciones.reduce((a, b) => a < b ? a : b);
      print('Asignatura: $asignatura, Calificación más alta: $maxCalificacion, Calificación más baja: $minCalificacion');
    });
  }

  /// Método para mostrar los estudiantes con promedio superior a un valor dado.
  void mostrarEstudiantesConPromedioSuperior() {
    double valorPromedio = _leerDouble('Ingrese el promedio mínimo:');

    var estudiantesSuperiores = estudiantes.where((e) => e.calcularPromedio() > valorPromedio).toList();

    if (estudiantesSuperiores.isEmpty) {
      print('No hay estudiantes con un promedio superior a $valorPromedio.');
    } else {
      print('Estudiantes con un promedio superior a $valorPromedio:');
      estudiantesSuperiores.forEach(print);
    }
  }

  /// Método para ordenar y mostrar la lista de estudiantes por su promedio.
  void ordenarEstudiantesPorPromedio({bool ascendente = true}) {
    estudiantes.sort((a, b) => ascendente 
        ? a.calcularPromedio().compareTo(b.calcularPromedio()) 
        : b.calcularPromedio().compareTo(a.calcularPromedio()));

    print('Estudiantes ordenados por promedio (${ascendente ? 'Ascendente' : 'Descendente'}):');
    estudiantes.forEach(print);
  }

  /// Método auxiliar para leer un número decimal (double) y manejar excepciones.
  double _leerDouble(String mensaje) {
    while (true) {
      try {
        print(mensaje);
        return double.parse(stdin.readLineSync()!);
      } catch (e) {
        print('Por favor, ingrese un número válido.');
      }
    }
  }
}

/// Función principal que controla el flujo del programa de gestión de calificaciones.
void main() {
  GestionCalificaciones gestion = GestionCalificaciones();
  bool continuar = true;

  while (continuar) {
    print('\n--- Gestión de Calificaciones de Estudiantes ---');
    print('1. Agregar nuevo estudiante');
    print('2. Mostrar promedio de cada estudiante');
    print('3. Mostrar calificación más alta y más baja por asignatura');
    print('4. Mostrar estudiantes con promedio superior a un valor');
    print('5. Ordenar estudiantes por promedio (ascendente/descendente)');
    print('6. Salir');

    int opcion = gestion._leerDouble('Seleccione una opción:').toInt();

    switch (opcion) {
      case 1:
        gestion.agregarEstudiante();
        break;
      case 2:
        gestion.mostrarPromedioEstudiantes();
        break;
      case 3:
        gestion.mostrarCalificacionesExtremas();
        break;
      case 4:
        gestion.mostrarEstudiantesConPromedioSuperior();
        break;
      case 5:
        print('Seleccione el orden: 1 para Ascendente, 2 para Descendente');
        int orden = gestion._leerDouble('Seleccione el orden:').toInt();
        gestion.ordenarEstudiantesPorPromedio(ascendente: orden == 1);
        break;
      case 6:
        continuar = false;
        print('Saliendo del programa...');
        break;
      default:
        print('Opción no válida. Intente nuevamente.');
    }
  }
}
