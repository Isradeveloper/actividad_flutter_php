class Usuario{

   final int USU_ID;
   final String USU_NOMBRES;
   final String USU_APELLIDOS;
   final String USU_CORREO;
   final String USU_GENERO;
   final String USU_ROL;
   final String USU_PASSWORD;
   
  Usuario({required this.USU_ID, required this.USU_NOMBRES, 
          required this.USU_APELLIDOS, 
          required this.USU_CORREO, required this.USU_GENERO, required this.USU_ROL,
          required this.USU_PASSWORD});
  
  factory Usuario.fromJson(Map<String,dynamic> json){
    return Usuario(
      USU_ID:         json["USU_ID"], 
      USU_NOMBRES:    json["USU_NOMBRES"], 
      USU_APELLIDOS:  json["USU_APELLIDOS"], 
      USU_CORREO:     json["USU_CORREO"], 
      USU_GENERO:     json["USU_GENERO"], 
      USU_ROL:        json["USU_ROL"], 
      USU_PASSWORD:   json["USU_PASSWORD"]);
  }

  Map<String , dynamic> toJson() => {
    "USU_NOMBRES"   :USU_NOMBRES,
    "USU_APELLIDOS" :USU_APELLIDOS,
    "USU_CORREO"    :USU_CORREO,
    "USU_GENERO"    :USU_GENERO,
    "USU_ROL"       :USU_ROL,
    "USU_PASSWORD"  :USU_PASSWORD
  };
}