//Marmolejo Uribe Karla Esmeralda

import 'package:dam_ejercicio8/ListMascota.dart';
import 'package:dam_ejercicio8/mascota.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<String> sexo =["Macho","Hembra"];
ListMascota data = ListMascota();

class App0208 extends StatefulWidget {
  const App0208({super.key});

  @override
  State<App0208> createState() => _App0208State();
}

class _App0208State extends State<App0208> {
  final txtNombre = TextEditingController();
  final user = TextEditingController();
  final contra = TextEditingController();
  final txtRaza = TextEditingController();
  final txtTipo = TextEditingController();
  int _indice = 0;
  var itemSeleccionado = sexo.first;
  String barra = "Veterinary Mascotas";


  void initState() {
    data.cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(barra),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: dinamico(),
      drawer: _indice != 0 ? Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(child: Icon(Icons.pets_rounded), radius: 30,),
                  Text("Tu Mejor Opción"),
                  Text("(C) Clinica Veterinaria ")
                ],
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            SizedBox(height: 20,),
            itemDrawer(1, Icons.add_box, "Capturar"),
            itemDrawer(2, Icons.insert_drive_file_outlined, "Mostrar"),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder:(BuildContext context){
                      return AlertDialog(
                        content: Text("¿SEGURO QUE DESEAS BORRAR \n TODO EL ALMACEN?"),
                        title: Text("ATENCIÓN"),
                        actions: [
                          TextButton(
                              onPressed: (){
                                setState(() {
                                  data.borrarAlmacen();
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Eliminar")
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                                setState(() {
                                  _indice=3;
                                });
                              },
                              child: Text("Solo borrar un elemento")
                          )
                        ],
                      );
                    });
              },
              title: Row(
                children: [
                  Expanded(child: Icon(Icons.delete_forever)),
                  Expanded(child: Text("Eliminar"), flex: 2,),
                ],
              ),
            ),
            itemDrawer(4, Icons.mode_rounded, "Actualizar"),
            itemDrawer(5, Icons.info_rounded, "Acerca de"),
            itemDrawer(0, Icons.close, "Cerrar Sesión"),
          ],
        ),
      ): null,
    );
  }

  Widget itemDrawer(int indice, IconData icono, String etiqueta) {
    return ListTile(
      onTap: () {
        setState(() {
          _indice = indice;
        });
        Navigator.pop(context);

      },
      title: Row(
        children: [
          Expanded(child: Icon(icono)),
          Expanded(child: Text(etiqueta), flex: 2,),
        ],
      ),
    );
  }

  Widget dinamico() {
    switch (_indice) {
      case 1:
        return registro();
      case 2:
        return verRegistros();
      case 3:
        return eliminar();
      case 4:
        return actualizar();
      case 5 :
        return acercade();
    }
    return login();
  }

  Widget registro() {
    return ListView(
      padding: EdgeInsets.all(50),
      children: [
        Center(
          child: Column(
            children: [
              Image.asset("assets/img1.jpg"),
              SizedBox(height: 15,),
              TextField(
                controller: txtNombre,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  suffixIcon: Icon(Icons.pets),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: txtRaza,
                decoration: InputDecoration(
                  labelText: "Raza",
                  suffixIcon: Icon(Icons.dataset_outlined),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: txtTipo,
                decoration: InputDecoration(
                  labelText: "Tipo de Animal",
                  suffixIcon: Icon(Icons.numbers_outlined),
                ),
              ),
              SizedBox(height: 20,),
              DropdownButtonFormField(
                  value: itemSeleccionado,
                  items: sexo.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (data) {
                    setState(() {
                      itemSeleccionado = data!;
                    });
                  }
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                      onPressed: () {
                        txtNombre.text = "";
                        txtRaza.text = "";
                        sexo.first;
                        txtTipo.text = "";
                      },
                      child: Text("Limpiar")),
                  FilledButton(
                      onPressed: () {
                        var m = Mascota(
                            Nombre: txtNombre.text,
                            Raza: txtRaza.text,
                            Sexo: itemSeleccionado.toString(),
                            Tipo: txtTipo.text
                        );
                        data.nuevo(m);
                        txtNombre.text = "";
                        txtRaza.text = "";
                        sexo.first;
                        txtTipo.text = "";
                      },
                      child: Text("Registrar")
                  ),

                ],
              )
            ],
          ),
        )
      ],
    );
  }
  Widget verRegistros() {
    final mascota = data.data;
    return ListView.builder(
        itemCount: mascota.length,
        itemBuilder: (context, indice) {
          return  ListTile(
              leading: CircleAvatar(child: Text("${indice}")),
              title: Text("${mascota[indice].Nombre}"),
              subtitle: Text("${mascota[indice].Tipo} - ${mascota[indice].Sexo}"),
              trailing: Icon(Icons.supervised_user_circle_outlined),
            );
        }
    );
  }
  Widget actualizar() {
    final mascota = data.data;
    return ListView.builder(
        itemCount: mascota.length,
        itemBuilder: (context, indice) {
          return ListTile(
            leading: CircleAvatar(child: Text("${indice}")),
            title: Text("${mascota[indice].Nombre}"),
            subtitle: Text("${mascota[indice].Tipo} - ${mascota[indice].Sexo}"),
            trailing: Icon(Icons.mode_rounded),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          "¿Seguro que deseas actualizar el Registro de: ${mascota[indice]
                              .Nombre}?"),
                      title: Text("ACTUALIZAR"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No")
                        ),
                        TextButton(
                            onPressed: () {
                              String seleccion = itemSeleccionado.toString();
                              Navigator.pop(context);
                              txtNombre.text = mascota[indice].Nombre;
                              txtTipo.text = mascota[indice].Tipo;
                              txtRaza.text = mascota[indice].Raza;
                              seleccion = mascota[indice].Sexo;
                              ventanaModal(indice);
                            },
                            child: Text("Si")
                        )
                      ],
                    );
                  }
              );
            },
          );
        }
        );
    }
  Widget eliminar() {
      final mascota = data.data;
      return ListView.builder(
          itemCount: mascota.length,
          itemBuilder: (context, indice) {
            return Dismissible(
                key: Key(mascota[indice].Nombre),
                onDismissed: (direction) {
                setState(() {
                data.eliminar(indice);
                data.guardarArchivo();
                });
            },
              child: ListTile(
                leading: CircleAvatar(child: Text("${indice}")),
                title: Text("${mascota[indice].Nombre}"),
                subtitle: Text(
                    "${mascota[indice].Tipo} - ${mascota[indice].Sexo}"),
                trailing: Icon(Icons.delete_forever),
              )
            );
          }
      );
    }
  Widget acercade() {
    return ListView(
      padding: EdgeInsets.all(50),
      children: [
        Image.asset("assets/img1.jpg"),
        SizedBox(height: 20,),
        Center(
            child: Text(
              "Para más Información Visita: \n www.veterinaria_green.com",
              style: TextStyle(color: Colors.brown, fontSize: 20),)
        ),
      ],
    );
  }
  Widget login() {
    return ListView(
      padding: EdgeInsets.all(50),
      children: [
        Container(
            height: 200,
            width: 400,
            child:Image.asset("assets/user.png")
        ),
        SizedBox(height: 20,),
        TextField(
          controller: user,
          decoration: InputDecoration(
            label: Text("Usuario:"),
            suffixIcon: Icon(Icons.supervised_user_circle),
          ),
        ),
        SizedBox(height: 20,),
        TextField(
          controller: contra,
          decoration: InputDecoration(
            labelText: "Contraseña:", // Cambio label a labelText
            suffixIcon: Icon(Icons.password),
          ),
          obscureText: true, // Oculta el texto ingresado
        ),

        SizedBox(height: 50,),
        ElevatedButton(
            onPressed: (){
              setState(() {
                if(contra.text=="12345" && user.text=="karla123"){
                  showDialog(
                      context: context,
                      builder: (builder){
                        return AlertDialog(
                          content:Text("Inicio de Sesión Exitoso") ,
                          title: Text("Accediendo..."),
                          actions: [
                            ElevatedButton(
                                onPressed:(){
                                  setState(() {
                                    _indice=1;
                                  });
                                  Navigator.pop(context);
                                  user.text="";
                                  contra.text="";
                                },
                                child: Text("OK")
                            )
                          ],
                        );
                      }
                  );
                }else{
                  showDialog(
                      context: context,
                      builder: (builder){
                        return AlertDialog(
                          content:Text("Usuario o contraseña incorrectos") ,
                          title: Text("Error"),
                          actions: [
                            ElevatedButton(
                                onPressed:(){
                                  Navigator.pop(context);
                                  user.text="";
                                  contra.text="";
                                },
                                child: Text("Volver")
                            )
                          ],
                        );
                      }
                  );
                }

              });
            },
            child: Text("Iniciar Sesión")
        )

      ],
    );
  }

  void ventanaModal(int index) {
    final mascota = data.data;
    showModalBottomSheet(
      context: context,
      elevation: 3,
      isScrollControlled: true,
      builder: (builder){
        return Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 10,
            right: 10,
            bottom:MediaQuery.of(context).viewInsets.bottom +40,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: txtNombre,
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    suffixIcon: Icon(Icons.pets),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: txtRaza,
                  decoration: InputDecoration(
                    labelText: "Raza",
                    suffixIcon: Icon(Icons.dataset_outlined),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: txtTipo,
                  decoration: InputDecoration(
                    labelText: "Tipo de Animal",
                    suffixIcon: Icon(Icons.numbers_outlined),
                  ),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                    value: itemSeleccionado,
                    items: sexo.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (data) {
                      setState(() {
                        itemSeleccionado = data!;
                      });
                    }
                ),
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(
                        onPressed: (){
                          Navigator.pop(context);
                          setState(() {
                            var mas = Mascota(
                              Nombre: txtNombre.text,
                              Raza: txtRaza.text,
                              Sexo: itemSeleccionado.toString(),
                              Tipo: txtTipo.text,
                            );
                            data.actualizar(mas, index);
                          });
                        },
                        child: Text("Actualizar"),
                    ),
                  ],
                )
              ],

            ),
          ),

        );
      }
  );
  }
}