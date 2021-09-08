import 'package:flutter/material.dart';
import 'package:football_points/classes/estado_partida.dart';
import 'package:football_points/classes/jogo.dart';
import 'package:football_points/result.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes/lista_jogos.dart';
import 'classes/lista_times.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> listaDeTimes = [''];
  String timeSelecionado = '';
  bool botaoAtualizaHabilitado = false;
  EstadoPatida resultadoDaPartida = EstadoPatida.na;

  _HomeState() {
    carregaTimes();
  }

  void carregaTimes() {
    ListaTimes.recuperaListaDeTimes()
        .then((times) => {this.listaDeTimes = times, setState(() {})});
  }

  void habilitaBotao() {
    this.botaoAtualizaHabilitado = this.timeSelecionado.isNotEmpty &&
        this.resultadoDaPartida != EstadoPatida.na;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.sourceSansPro(
            textStyle: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
        ),
        leading: Icon(
          Icons.sports_soccer,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 50),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          margin:
              EdgeInsets.only(left: 3.0, top: 15.0, right: 3.0, bottom: 3.0),
          child: Column(
            children: [
              Text(
                'Escolha o time?',
                style: GoogleFonts.sourceSansPro(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              DropdownButton<String>(
                  value: timeSelecionado,
                  items: listaDeTimes.map((nome) {
                    return DropdownMenuItem<String>(
                      value: nome,
                      child: Text(nome),
                    );
                  }).toList(),
                  onChanged: (String? content) {
                    setState(() {
                      this.timeSelecionado = content!;
                      this.habilitaBotao();
                    });
                  }),
              Text(
                'O time ganhou, empatou ou perdeu o último jogo?',
                style: GoogleFonts.sourceSansPro(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Center(child: UltimoJogo(onSelect: (resultado) {
                setState(() {
                  this.resultadoDaPartida = resultado;
                  this.habilitaBotao();
                });
              })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          botaoAtualizaHabilitado ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      if (botaoAtualizaHabilitado) {
                        Jogo jogo = Jogo(timeSelecionado, resultadoDaPartida);
                        ListaDeJogos.getInstance().adicionaJogo(jogo);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaResultado(
                              title: 'Tabela de Classificação',
                              listaDeTimes: this.listaDeTimes,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Atualizar Tabela de Pontos',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaResultado(
                            title: 'Tabela de Classificação',
                            listaDeTimes: this.listaDeTimes,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Ver Classificação',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UltimoJogo extends StatefulWidget {
  final ValueChanged<EstadoPatida> onSelect;

  UltimoJogo({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<UltimoJogo> createState() => _UltimoJogoState(onSelect: this.onSelect);
}

/// This is the private State class that goes with MyStatefulWidget.
class _UltimoJogoState extends State<UltimoJogo> {
  final ValueChanged<EstadoPatida> onSelect;
  EstadoPatida _resultado = EstadoPatida.na;

  _UltimoJogoState({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ListTile(
          title: const Text('Ganhou'),
          leading: Radio<EstadoPatida>(
            value: EstadoPatida.ganhou,
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
          title: const Text('Empatou'),
          leading: Radio<EstadoPatida>(
            value: EstadoPatida.empatou,
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
          title: const Text('Perdeu'),
          leading: Radio<EstadoPatida>(
            value: EstadoPatida.perdeu,
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
    );
  }
}
