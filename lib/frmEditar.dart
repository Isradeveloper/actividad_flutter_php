import 'package:actividad_flutter_php/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ruta.dart';
import 'dart:convert';

class frmEditar extends StatefulWidget {
  final Usuario user;
  const frmEditar({Key? key, required this.user}) : super(key: key);

  @override
  State<frmEditar> createState() => _frmEditarState();
}

class _frmEditarState extends State<frmEditar> {
  @override
  void initState() {
    super.initState();
    cNombre = TextEditingController(text: widget.user.USU_NOMBRES);
    cApellido = TextEditingController(text: widget.user.USU_APELLIDOS);
    cCorreo = TextEditingController(text: widget.user.USU_CORREO);
    genero = widget.user.USU_GENERO;
    rol = widget.user.USU_ROL;
  }

  TextEditingController cNombre = TextEditingController();
  TextEditingController cApellido = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  // TextEditingController cRol = TextEditingController();
  // TextEditingController cGenero = TextEditingController();
  String genero = "Masculino";
  String rol = "Admin";
  Map<String, String> requestHeaders = {
    'Authorization': '123456789',
  };
  Future edtUsuario(context) async {
    final respuesta = await http.post(
      Uri.parse("${Ruta.DIR_SERVIDOR}edtUsuario.php"),
      body: {
        'USU_NOMBRES': cNombre.text,
        'USU_APELLIDOS': cApellido.text,
        'USU_CORREO': cCorreo.text,
        'USU_ROL': rol,
        'USU_GENERO': genero,
        'USU_PASSWORD': cCorreo.text,
        'USU_ID': widget.user.USU_ID.toString()
      },
      headers: requestHeaders,
    );
    final items = json.decode(respuesta.body);
    Mensaje(context, items["respuesta"]);
  }

// flutter run -d chrome --web-browser-flag "--disable-web-security"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            "Editar Usuario ${widget.user.USU_ID} - ${widget.user.USU_NOMBRES} ${widget.user.USU_APELLIDOS}"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: const Text(
                  "Editar usuario",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: cNombre,
                decoration: InputDecoration(
                  label: const Text(
                    'Nombres',
                    style: TextStyle(color: Colors.blue),
                  ),
                  hintText: 'Digite nombres',
                  hintStyle:
                      const TextStyle(fontSize: 14.0, color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: cApellido,
                decoration: InputDecoration(
                  label: const Text(
                    'Apellidos',
                    style: TextStyle(color: Colors.blue),
                  ),
                  hintText: 'Digite Apellidos',
                  hintStyle:
                      const TextStyle(fontSize: 14.0, color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: cCorreo,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: const Text(
                    'Correo',
                    style: TextStyle(color: Colors.blue),
                  ),
                  hintText: 'Digite correo',
                  hintStyle:
                      const TextStyle(fontSize: 14.0, color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Seleccione Genero",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.blue,
                ),
                child: RadioListTile(
                    value: "Masculino",
                    activeColor: Colors.blue,
                    groupValue: genero,
                    title: const Text(
                      "Masculino",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onChanged: (value) {
                      setState(() {
                        genero = value.toString();
                      });
                    }),
              ),
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.blue,
                ),
                child: RadioListTile(
                    value: "Femenino",
                    activeColor: Colors.blue,
                    title: const Text(
                      "Femenino",
                      style: TextStyle(color: Colors.blue),
                    ),
                    groupValue: genero,
                    onChanged: (value) {
                      setState(() {
                        genero = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Seleccione Rol",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.blue,
                ),
                child: RadioListTile(
                    value: "Admin",
                    groupValue: rol,
                    activeColor: Colors.blue,
                    title: const Text(
                      "Admin",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onChanged: (value) {
                      setState(() {
                        rol = value.toString();
                      });
                    }),
              ),
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.blue,
                ),
                child: RadioListTile(
                    value: "Supervisor",
                    activeColor: Colors.blue,
                    title: const Text(
                      "Supervisor",
                      style: TextStyle(color: Colors.blue),
                    ),
                    groupValue: rol,
                    onChanged: (value) {
                      setState(() {
                        rol = value.toString();
                      });
                    }),
              ),
              ElevatedButton(
                onPressed: () {
                  edtUsuario(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // primary: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                child: const Text("Actualizar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
