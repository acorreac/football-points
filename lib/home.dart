import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_points/classes/estado_partida.dart';
import 'package:football_points/classes/jogo.dart';
import 'package:football_points/classes/time.dart';
import 'package:football_points/result.dart';
import 'package:football_points/tela_login.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes/lista_jogos.dart';
import 'classes/lista_times.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Set<Time> listaDeTimes = Set();
  Time timeSelecionado = Time.toTimeSemEscudo('');
  bool botaoAtualizaHabilitado = false;
  EstadoPartida resultadoDaPartida = EstadoPartida.naoSelecionado;

  _HomeState() {
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

  void habilitaBotao() {
    this.botaoAtualizaHabilitado = this.timeSelecionado.nome.isNotEmpty &&
        this.resultadoDaPartida != EstadoPartida.naoSelecionado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 150.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/plano-fundo-home.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Card(
                    color: Colors.white.withOpacity(0.5),
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
                          Text(
                            'Escolha o time!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.newsCycle(
                                color: Colors.black,
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                          ),
                          Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DropdownButton<Time>(
                                  dropdownColor: Colors.white.withOpacity(0.8),
                                  icon: Icon(
                                    Icons.sports_soccer_outlined,
                                    color: Colors.green,
                                  ),
                                  value: timeSelecionado,
                                  items: listaDeTimes.map(
                                    (time) {
                                      return DropdownMenuItem<Time>(
                                        value: time,
                                        child: Text(
                                          time.nome.toUpperCase(),
                                          style: GoogleFonts.newsCycle(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (Time? content) {
                                    setState(
                                      () {
                                        this.timeSelecionado = content!;
                                        this.habilitaBotao();
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                ),
                                Text(
                                  'O time ganhou, empatou ou perdeu o último jogo?',
                                  style: GoogleFonts.newsCycle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 230.h),
                                  child: UltimoJogo(
                                    onSelect: (resultado) {
                                      setState(
                                        () {
                                          this.resultadoDaPartida = resultado;
                                          this.habilitaBotao();
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.only(
                                            top: 15.h, bottom: 15.h),
                                        primary: botaoAtualizaHabilitado
                                            ? Colors.green
                                            : Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (botaoAtualizaHabilitado) {
                                          Jogo jogo = Jogo(
                                              time: timeSelecionado,
                                              resultado: resultadoDaPartida);
                                          ListaDeJogos.getInstance()
                                              .adicionaJogo(jogo);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TelaResultado(
                                                listaDeTimes:
                                                    this.listaDeTimes.toList(),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        'ATUALIZAR TABELA DE PONTOS',
                                        style: GoogleFonts.newsCycle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.only(
                                            top: 15.h, bottom: 15.h),
                                        primary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TelaLogin(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'VOLTAR',
                                        style: GoogleFonts.newsCycle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UltimoJogo extends StatefulWidget {
  final ValueChanged<EstadoPartida> onSelect;

  UltimoJogo({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<UltimoJogo> createState() => _UltimoJogoState(onSelect: this.onSelect);
}

class _UltimoJogoState extends State<UltimoJogo> {
  final ValueChanged<EstadoPartida> onSelect;
  EstadoPartida _resultado = EstadoPartida.naoSelecionado;

  _UltimoJogoState({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Ganhou',
              style: GoogleFonts.newsCycle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            leading: Radio<EstadoPartida>(
              activeColor: Colors.green,
              value: EstadoPartida.ganhou,
              groupValue: _resultado,
              onChanged: (value) {
                setState(() {
                  _resultado = value!;
                  this.onSelect(_resultado);
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Empatou',
              style: GoogleFonts.newsCycle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            leading: Radio<EstadoPartida>(
              activeColor: Colors.green,
              value: EstadoPartida.empatou,
              groupValue: _resultado,
              onChanged: (value) {
                setState(() {
                  _resultado = value!;
                  this.onSelect(_resultado);
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Perdeu',
              style: GoogleFonts.newsCycle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            leading: Radio<EstadoPartida>(
              activeColor: Colors.green,
              value: EstadoPartida.perdeu,
              groupValue: _resultado,
              onChanged: (value) {
                setState(() {
                  _resultado = value!;
                  this.onSelect(_resultado);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
