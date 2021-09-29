import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:football_points/tela_login.dart';
import 'package:football_points/values/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_models.dart';
import 'values/preferences_keys.dart';

class UserCadastro extends StatefulWidget {
  @override
  _UserCadastroState createState() => _UserCadastroState();
}

class _UserCadastroState extends State<UserCadastro> {
  TextEditingController _nameInputController = TextEditingController();
  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();
  TextEditingController _confirmInputController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors().getGradienteSecColor(),
              CustomColors().getGradientMainColor(),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 540.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 100.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: SvgPicture.asset(
                              "images/login-icon.svg",
                              height: 350.h,
                              width: 350.w,
                            ),
                          ),
                          Text(
                            'Cadastro',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameInputController,
                                  autofocus: true,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Nome Completo',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25.sp,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                      size: 50.h,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _mailInputController,
                                  autofocus: true,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25.sp,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mail_outline,
                                      color: Colors.black,
                                      size: 50.h,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 50.w,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _passwordInputController,
                                  obscureText: !(this.showPassword == false)
                                      ? false
                                      : true,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25.sp,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.vpn_key_sharp,
                                      color: Colors.black,
                                      size: 50.h,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                (this.showPassword == false)
                                    ? TextFormField(
                                        controller: _confirmInputController,
                                        obscureText: true,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          labelText: 'Confirme a Senha',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.sp,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.vpn_key_sharp,
                                            color: Colors.black,
                                            size: 50.h,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: this.showPassword,
                                      onChanged: (newValue) {
                                        setState(() {
                                          this.showPassword = newValue!;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    Text(
                                      'Mostrar senha',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 20,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.only(top: 40.h, bottom: 40.h),
                                  primary:
                                      CustomColors().getGradientMainColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                onPressed: () {
                                  _doSignUp();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TelaLogin(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _doSignUp() {
    User newUser = User(
      name: _nameInputController.text,
      mail: _mailInputController.text,
      password: _passwordInputController.text,
      keepOn: true,
    );
    print(newUser);
    salvaUsuario(newUser);
  }

  Future<void> salvaUsuario(User user) async {
    Future<SharedPreferences> _localStorage = SharedPreferences.getInstance();
    final SharedPreferences localStorage = await _localStorage;
    String usuarioAtivo = PreferencesKeys.usuarioAtivo;
    String valor = json.encode(user.toJson());
    localStorage.setString(usuarioAtivo, valor);

    armazenaUsuarioNaLista(user, localStorage);
  }

  void armazenaUsuarioNaLista(User user, SharedPreferences localStorage) {
    recuperaUsuarios().then((usuariosSalvos) => {
          adicionaUsuarioNaMemoria(user, localStorage, usuariosSalvos),
        });
  }

  adicionaUsuarioNaMemoria(
      User user, SharedPreferences localStorage, ListaDeUsuarios lista) {
    lista.adicionaUsuario(user);
    String chave = PreferencesKeys.usuariosSalvos;
    String valor = json.encode(lista.toJson());
    localStorage.setString(chave, valor);
  }

  Future<ListaDeUsuarios> recuperaUsuarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usuariosEmMemoria = prefs.getString(PreferencesKeys.usuariosSalvos);

    if (usuariosEmMemoria == null) {
      return ListaDeUsuarios(usuarios: []);
    } else {
      Map<String, dynamic> mapUsers = json.decode(usuariosEmMemoria);
      ListaDeUsuarios usuarios = ListaDeUsuarios.fromJson(mapUsers);
      return usuarios;
    }
  }
}
