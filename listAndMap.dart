void main() {
  // Ejemplo de List
  List<int> numeros = [10, 20, 30, 40, 50];
  // Agregando elementos a la lista
  numeros.add(60);
  print("Lista después de agregar 60: $numeros");
  // Eliminando un elemento
  numeros.remove(20);
  print("Lista después de eliminar 20: $numeros");
  // Accediendo a un elemento por índice
  print("Elemento en el índice 2: ${numeros[2]}");
  // Recorrer la lista
  print("Recorriendo la lista:");
  for (var numero in numeros) {
    print(numero);
  }
  // Ejemplo de Map
  Map<String, int> edades = {
    "Juan": 25,
    "María": 30,
    "Luis": 28
  };
  // Agregando una nueva clave-valor al mapa
  edades["Ana"] = 22;
  print("Mapa después de agregar a Ana: $edades");
  // Modificando el valor asociado a una clave
  edades["Juan"] = 26;
  print("Mapa después de actualizar la edad de Juan: $edades");
  // Eliminando una clave-valor del mapa
  edades.remove("María");
  print("Mapa después de eliminar a María: $edades");
  // Accediendo a un valor por su clave
  print("Edad de Luis: ${edades["Luis"]}");
  // Recorrer el mapa
  print("Recorriendo el mapa:");
  edades.forEach((nombre, edad) {
    print("$nombre tiene $edad años");
  });
}
