import 'package:flutter/material.dart';
import 'package:football_points/classes/lista_jogos.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes/jogo.dart';
import 'classes/resultado_time.dart';

class TelaResultado extends StatefulWidget {
  TelaResultado({Key? key, required this.title, required this.listaDeTimes})
      : super(key: key);

  final String title;
  final List<String> listaDeTimes;

  @override
  _TelaResultadoState createState() => _TelaResultadoState(listaDeTimes);
}

class _TelaResultadoState extends State<TelaResultado> {
  ResultadosPorTime resultados = ResultadosPorTime([]);
  List<String>? listaDeTimes;

  _TelaResultadoState(List<String> listaDeTimes) {
    this.listaDeTimes = listaDeTimes;
    this.resultados = ResultadosPorTime(listaDeTimes);
    List<Jogo> jogos = ListaDeJogos.getInstance().recuperaJogos();
    jogos.forEach((jogo) {
      resultados.computa(jogo);
    });
  }

  List<TableRow> recuperaLinhasTabela() {
    List<TableRow> linhas = [];
    TableRow header = TableRow(
      children: [
        new Text('Times'),
        new Text('Vitorias'),
        new Text('Empates'),
        new Text('Derrotas'),
        new Text('Total de Pontos'),
      ],
    );
    linhas.add(header);

    List<DadosTabela> dadosDosTimes = resultados.recuperaDadosTimes();
    List<DadosTabela> dadosFiltrados =
        dadosDosTimes.where((element) => element.nome.isNotEmpty).toList();
    dadosFiltrados.sort((jogo1, jogo2) {
      return jogo2
          .recuperaPontosTotais()
          .compareTo(jogo1.recuperaPontosTotais());
    });
    dadosFiltrados.forEach((dadosDoTime) {
      linhas.add(new TableRow(children: [
        Text(dadosDoTime.nome),
        Text(dadosDoTime.vitorias.toString()),
        Text(dadosDoTime.empates.toString()),
        Text(dadosDoTime.derrotas.toString()),
        Text(dadosDoTime.recuperaPontosTotais().toString()),
      ]));
    });
    return linhas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
      body: Column(
        children: [
          Table(
            children: recuperaLinhasTabela(),
            border: TableBorder(
                horizontalInside: BorderSide(width: 1, color: Colors.blueGrey)),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Retornar a Home'),
            ),
          ),
        ],
      ),
    );
  }
}
