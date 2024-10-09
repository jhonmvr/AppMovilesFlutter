import 'dart:io';  // Importación para usar funciones relacionadas con la entrada/salida de la consola.

/// Clase que representa un producto en el inventario.
class Producto {
  String nombre;
  double precio;
  int cantidadStock;
  String categoria;

  // Constructor que inicializa un objeto de tipo Producto.
  Producto(this.nombre, this.precio, this.cantidadStock, this.categoria);

  // Sobrescribe el método toString para dar formato a la impresión del objeto Producto.
  @override
  String toString() {
    return 'Nombre: $nombre, Precio: \$${precio.toStringAsFixed(2)}, Stock: $cantidadStock, Categoría: $categoria';
  }
}

/// Clase que representa el inventario y contiene métodos para gestionar productos.
class Inventario {
  // Lista que almacena los productos en el inventario.
  List<Producto> productos = [];

  /// Método para agregar un nuevo producto al inventario. Pide datos al usuario.
  void agregarProducto() {
    print('Ingrese el nombre del producto:');
    String nombre = stdin.readLineSync()!;

    double precio = _leerDouble('Ingrese el precio del producto:');
    int cantidadStock = _leerInt('Ingrese la cantidad en stock:');
    print('Ingrese la categoría del producto:');
    String categoria = stdin.readLineSync()!;

    Producto producto = Producto(nombre, precio, cantidadStock, categoria);
    productos.add(producto);
    print('Producto agregado exitosamente.');
  }

  /// Método que busca un producto por su nombre y lo muestra.
  void buscarProductoPorNombre() {
    print('Ingrese el nombre del producto a buscar:');
    String nombre = stdin.readLineSync()!;
    var resultados = productos
        .where((p) => p.nombre.toLowerCase() == nombre.toLowerCase())
        .toList();

    if (resultados.isEmpty) {
      print('No se encontró ningún producto con el nombre "$nombre".');
    } else {
      print('Productos encontrados:');
      resultados.forEach(print);
    }
  }

  /// Método que busca productos por una categoría dada.
  void buscarProductoPorCategoria() {
    print('Ingrese la categoría de productos a buscar:');
    String categoria = stdin.readLineSync()!;
    var resultados = productos
        .where((p) => p.categoria.toLowerCase() == categoria.toLowerCase())
        .toList();

    if (resultados.isEmpty) {
      print('No se encontraron productos en la categoría "$categoria".');
    } else {
      print('Productos encontrados:');
      resultados.forEach(print);
    }
  }

  /// Método que actualiza la cantidad en stock de un producto dado su nombre.
  void actualizarCantidadStock() {
    print('Ingrese el nombre del producto para actualizar el stock:');
    String nombre = stdin.readLineSync()!;
    var producto = productos.firstWhere(
      (p) => p.nombre.toLowerCase() == nombre.toLowerCase(),
      orElse: () => Producto('Producto no encontrado', 0.0, 0, 'N/A'),
    );

    if (producto.nombre == 'Producto no encontrado') {
      print('No se encontró el producto "$nombre".');
    } else {
      producto.cantidadStock = _leerInt('Ingrese la nueva cantidad en stock:');
      print('Stock actualizado exitosamente.');
    }
  }

  /// Método que calcula y muestra el valor total del inventario.
  void calcularValorTotalInventario() {
    double valorTotal =
        productos.fold(0, (total, p) => total + (p.precio * p.cantidadStock));
    print('El valor total del inventario es: \$${valorTotal.toStringAsFixed(2)}');
  }

  /// Método que muestra todas las categorías disponibles y permite al usuario seleccionar una para ver los productos.
  void mostrarProductosPorCategoria() {
    // Extraer categorías únicas
    var categorias = productos.map((p) => p.categoria).toSet().toList();

    if (categorias.isEmpty) {
      print('No hay productos en el inventario.');
      return;
    }

    // Mostrar las categorías disponibles
    print('Categorías disponibles:');
    for (int i = 0; i < categorias.length; i++) {
      print('${i + 1}. ${categorias[i]}');
    }

    // El usuario selecciona una categoría por número
    int seleccion = _leerInt('Seleccione una categoría por número:') - 1;
    if (seleccion < 0 || seleccion >= categorias.length) {
      print('Selección inválida. Intente nuevamente.');
      return;
    }

    // Mostrar productos de la categoría seleccionada
    String categoriaSeleccionada = categorias[seleccion];
    var productosCategoria = productos
        .where((p) => p.categoria.toLowerCase() == categoriaSeleccionada.toLowerCase())
        .toList();

    if (productosCategoria.isEmpty) {
      print('No hay productos en la categoría "$categoriaSeleccionada".');
    } else {
      print('Productos en la categoría "$categoriaSeleccionada":');
      productosCategoria.forEach(print);
    }
  }

  /// Método auxiliar para leer un número decimal (double) y manejar excepciones.
  double _leerDouble(String mensaje) {
    while (true) {
      try {
        print(mensaje);
        return double.parse(stdin.readLineSync()!);
      } catch (e) {
        print('Por favor, ingrese un número válido para el precio.');
      }
    }
  }

  /// Método auxiliar para leer un número entero (int) y manejar excepciones.
  int _leerInt(String mensaje) {
    while (true) {
      try {
        print(mensaje);
        return int.parse(stdin.readLineSync()!);
      } catch (e) {
        print('Por favor, ingrese un número entero válido para la cantidad.');
      }
    }
  }
}

/// Función principal que controla el flujo del programa de gestión de inventario.
void main() {
  Inventario inventario = Inventario();
  bool continuar = true;

  // Ciclo principal que muestra el menú y permite seleccionar acciones.
  while (continuar) {
    print('\n--- Gestión de Inventario ---');
    print('1. Agregar nuevo producto');
    print('2. Buscar producto por nombre');
    print('3. Buscar producto por categoría');
    print('4. Actualizar cantidad en stock');
    print('5. Calcular valor total del inventario');
    print('6. Mostrar productos por categoría');
    print('7. Salir');

    int opcion = inventario._leerInt('Seleccione una opción:');

    switch (opcion) {
      case 1:
        inventario.agregarProducto();
        break;
      case 2:
        inventario.buscarProductoPorNombre();
        break;
      case 3:
        inventario.buscarProductoPorCategoria();
        break;
      case 4:
        inventario.actualizarCantidadStock();
        break;
      case 5:
        inventario.calcularValorTotalInventario();
        break;
      case 6:
        inventario.mostrarProductosPorCategoria();
        break;
      case 7:
        continuar = false;
        print('Saliendo del programa...');
        break;
      default:
        print('Opción no válida. Intente nuevamente.');
    }
  }
}
