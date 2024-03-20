//Marmolejo Uribe Karla Esmeralda

import 'package:dam_ejercicio8/mascota.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListMascota{
  List<Mascota> data=[];
  Mascota toMascota(String cod){
    List res = cod.split("&&");
    Mascota mas = Mascota(
        Nombre: res[0],
        Raza: res[1],
        Sexo: res[2],
        Tipo: res[3]
    );
  return mas;
  }

  Future<bool> guardarArchivo() async{
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer=[];
    data.forEach((element){
      buffer.add(element.toString());
    });
    almacen.setStringList("buffer", buffer);//Guarda
    return true;
  }

  Future cargarDatos() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    buffer = almacen.getStringList("buffer") ?? [];
    data.clear();
    buffer.forEach((element) {
      data.add(toMascota(element));//nombre&&raza&&sexo&&tipo
    });
  }

  Future<bool> borrarAlmacen() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    almacen.remove("buffer");
    data.clear();
    return true;
  }

  void nuevo(Mascota mascota){
    data.add(mascota);
  }

  void actualizar(Mascota ma,int pos){
    data[pos] = ma;
    guardarArchivo();
  }

  void eliminar(int pos){
    data.removeAt(pos);
    guardarArchivo();
  }
}
