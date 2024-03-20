class Mascota{
  String Nombre;
  String Raza;
  String Sexo;
  String Tipo;

  Mascota({
    required this.Nombre,
    required this.Raza,
    required this.Sexo,
    required this.Tipo
  });

  String toString(){
    return "$Nombre&&$Raza&&$Sexo&&$Tipo";
  }
}