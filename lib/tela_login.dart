import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:football_points/home.dart';
import 'package:football_points/result.dart';
import 'package:football_points/user_cadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/estado_partida.dart';
import 'classes/lista_times.dart';
import 'classes/time.dart';
import 'models/user_models.dart';
import 'values/custom_colors.dart';
import 'values/preferences_keys.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  Set<Time> listaDeTimes = Set();
  Time timeSelecionado = Time.toTimeSemEscudo('');
  bool botaoAtualizaHabilitado = false;
  EstadoPartida resultadoDaPartida = EstadoPartida.naoSelecionado;

  _TelaLoginState() {
    carregaTimes();
  }

  void carregaTimes() {
    ListaTimes.recuperaListaDeTimes().then((times) => {
          this.listaDeTimes = times.toSet(),
          setState(() {}),
          this.timeSelecionado =
              listaDeTimes.firstWhere((time) => time.nome.isEmpty)
        });
  }

  bool continueConnected = false;

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
                CustomColors().getGradientMainColor(),
                CustomColors().getGradienteSecColor(),
              ]),
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
                            'Entrar',
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
                                  controller: _mailInputController,
                                  autofocus: true,
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
                                  obscureText: true,
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
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Esqueceu a senha?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: this.continueConnected,
                                      onChanged: (newValue) {
                                        setState(() {
                                          this.continueConnected = newValue!;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    Text(
                                      'Continuar Conetectado?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.only(
                                            top: 40.h, bottom: 40.h),
                                        primary: CustomColors()
                                            .getGradientMainColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      onPressed: () {
                                        _doLogin();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Login',
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                    height: 25.h,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Ainda não tem uma conta?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.only(
                                            top: 40.h, bottom: 40.h),
                                        primary: CustomColors()
                                            .getActiveSecondaryButtonColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserCadastro(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Cadastre-se',
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                    height: 25.h,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Tabela de Classificação',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.only(
                                            top: 40.h, bottom: 40.h),
                                        primary: CustomColors()
                                            .getActiveSecondaryButtonColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TelaResultado(
                                              listaDeTimes:
                                                  this.listaDeTimes.toList(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Ver Classificação',
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
                                  padding: EdgeInsets.only(bottom: 30),
                                ),
                              ],
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

  void _doLogin() async {
    String mailForm = this._mailInputController.text;
    String passwordForm = this._passwordInputController.text;
    ListaDeUsuarios savedUsers = await _getSavedUsers();
    Iterable<User> itUsuario = savedUsers.recuperaUsuarios().where((usuario) =>
        usuario.mail == mailForm && usuario.password == passwordForm);

    if (itUsuario.isNotEmpty) {
      User usuarioLogado = itUsuario.first;
      print('LOGIN EFETUADO COM SUCESSO. $usuarioLogado');
    } else {
      print('FALHA NO LOGIN');
    }
  }

  Future<ListaDeUsuarios> _getSavedUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(PreferencesKeys.usuariosSalvos);

    if (jsonUser == null) {
      return ListaDeUsuarios(usuarios: []);
    } else {
      Map<String, dynamic> mapUser = json.decode(jsonUser);
      ListaDeUsuarios users = ListaDeUsuarios.fromJson(mapUser);
      return users;
    }
  }
}
