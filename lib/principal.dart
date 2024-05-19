import 'package:actividad_flutter_php/frmEditar.dart';
import 'package:flutter/material.dart';
import 'usuario.dart';
import 'package:http/http.dart' as http;
import 'ruta.dart';
import 'dart:convert';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late Future<List<Usuario>> usuarios;
  late int usuarioSeleccionado;

  @override
  void initState() {
    super.initState();
    usuarios = getUsuarios();
    usuarioSeleccionado = 0;
  }

  Map<String, String> requestHeaders = {
    'Authorization': '123456789',
  };

  Future<List<Usuario>> getUsuarios() async {
    final r = await http.get(
      Uri.parse("${Ruta.DIR_SERVIDOR}lisUsuario.php"),
      headers: requestHeaders,
    );

    final it = json.decode(r.body).cast<Map<String, dynamic>>();

    List<Usuario> us = it.map<Usuario>((json) {
      return Usuario.fromJson(json);
    }).toList();
    return us;
  }

  Future eliminarUsuario(context, id) async {
    final respuesta = await http.post(
      Uri.parse("${Ruta.DIR_SERVIDOR}eliUsuario.php"),
      body: {
        'ID': id.toString(),
      },
      headers: requestHeaders,
    );
    final items = json.decode(respuesta.body);
    Mensaje(context, items["respuesta"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado usuarios")),
      body: Container(
        margin: const EdgeInsets.only(bottom: 100),
        child: Center(
          child: FutureBuilder<List<Usuario>>(
            future: usuarios,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var datos = snapshot.data[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      trailing: Wrap(
                        spacing: -16,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        frmEditar(user: datos),
                                  ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              MensajeValidacion(context, () {
                                eliminarUsuario(context, datos.USU_ID);
                              });
                            },
                          ),
                        ],
                      ),
                      title: Text(
                        datos.USU_NOMBRES,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        datos.USU_CORREO,
                        style: const TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => frmEditar(user: datos),
                            ));
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),

      // ---------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/frmRegistro');
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}

MensajeValidacion(context, Function callback) {
  Widget okButton = TextButton(
    child: const Text("Aceptar"),
    onPressed: () {
      callback();
      Navigator.pop(context);
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancelar"),
    onPressed: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Alerta"),
    content: const Text("¿Estás seguro de realizar esta acción?"),
    actions: [okButton, cancelButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Mensaje(context, String sms) {
  Widget okButton = TextButton(
    child: const Text("Aceptar"),
    onPressed: () {
      // Navigator.pop(context);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Mensaje"),
    content: Text(sms),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
