class User {
  String name;
  String mail;
  String password;
  bool keepOn;

  User(
      {required this.name,
      required this.mail,
      required this.password,
      required this.keepOn});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mail = json['mail'],
        password = json['password'],
        keepOn = json['keepOn'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mail'] = this.mail;
    data['password'] = this.password;
    data['keepOn'] = this.keepOn;
    return data;
  }

  String toString() {
    return 'Name: ' + this.name + '\n E-mail: ' + this.mail;
  }
}

class ListaDeUsuarios {
  List<User> usuarios;

  ListaDeUsuarios({required this.usuarios});

  void adicionaUsuario(User usuario) {
    this.usuarios.add(usuario);
  }

  List<User> recuperaUsuarios() {
    return usuarios;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuarios'] = this.usuarios;
    return data;
  }

  static ListaDeUsuarios fromJson(Map<String, dynamic> json) {
    List<User> usuarios = [];
    List<dynamic> usuariosJson = json['usuarios'];
    usuariosJson.forEach((usuario) {
      usuarios.add(User.fromJson(usuario));
    });
    return ListaDeUsuarios(usuarios: usuarios);
  }
}
