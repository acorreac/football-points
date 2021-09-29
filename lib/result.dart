import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:football_points/classes/lista_jogos.dart';
import 'package:football_points/classes/time.dart';
import 'package:football_points/tela_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'classes/jogo.dart';
import 'classes/resultado_time.dart';

class TelaResultado extends StatefulWidget {
  TelaResultado({Key? key, required this.listaDeTimes}) : super(key: key);

  final List<Time> listaDeTimes;

  @override
  _TelaResultadoState createState() =>
      _TelaResultadoState(listaDeTimes: listaDeTimes);
}

class _TelaResultadoState extends State<TelaResultado> {
  ResultadosPorTime resultados = ResultadosPorTime([]);
  List<Time> listaDeTimes;

  _TelaResultadoState({required this.listaDeTimes}) {
    this.resultados = ResultadosPorTime(this.listaDeTimes);
    List<Jogo> jogos = ListaDeJogos.getInstance().recuperaJogos();
    jogos.forEach((jogo) {
      resultados.computa(jogo);
    });
  }

  List<TableRow> recuperaLinhasTabela() {
    List<TableRow> linhas = [];
    TableRow header = TableRow(
      children: [
        imprimeTitulo('Posição'),
        imprimeTitulo(''),
        imprimeTitulo('V'),
        imprimeTitulo('E'),
        imprimeTitulo('D'),
        imprimeTitulo('PTS'),
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
    int posicao = 0;
    dadosFiltrados.forEach((dadosDoTime) {
      posicao += 1;
      linhas.add(
        TableRow(children: [
          imprimePosicao(text: '$posicaoº', alinhamento: Alignment.center),
          imprimeColunaTimes(
              escudo: dadosDoTime.escudo,
              text: dadosDoTime.nome,
              alinhamento: Alignment.center),
          imprimeCelula(
            text: dadosDoTime.vitorias.toString(),
          ),
          imprimeCelula(
            text: dadosDoTime.empates.toString(),
          ),
          imprimeCelula(
            text: dadosDoTime.derrotas.toString(),
          ),
          imprimeCelula(
            text: dadosDoTime.recuperaPontosTotais().toString(),
          ),
        ]),
      );
    });
    return linhas;
  }

  Widget imprimeTitulo(String text,
      [Alignment alinhamento = Alignment.center]) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(2),
        alignment: alinhamento,
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: GoogleFonts.newsCycle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      //),
    ]);
  }

  Widget imprimePosicao(
      {String escudo = '',
      String text = '',
      Alignment alinhamento = Alignment.center}) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.red.withOpacity(0.3),
            )
          ],
        ),
        child: Align(
          alignment: alinhamento,
          child: Text(
            text.toUpperCase(),
            style: GoogleFonts.newsCycle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ]);
  }

  Widget imprimeColunaTimes(
      {String escudo = '',
      String text = '',
      Alignment alinhamento = Alignment.center}) {
    return Container(
      width: 370.w,
      margin: EdgeInsets.all(2),
      alignment: alinhamento,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          new BoxShadow(
            color: Colors.blue.withOpacity(0.1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (escudo.isNotEmpty)
            Align(
              alignment: alinhamento,
              child: SvgPicture.network(
                escudo,
                height: 32.h,
                width: 32.w,
              ),
            ),
          SizedBox(width: 2.w),
          Text(
            text.toUpperCase(),
            style: GoogleFonts.newsCycle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget imprimeCelula(
      {String escudo = '',
      String text = '',
      Alignment alinhamento = Alignment.center}) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            new BoxShadow(
              color: Colors.blue.withOpacity(0.1),
            )
          ],
        ),
        child: Align(
          alignment: alinhamento,
          child: Text(
            text.toUpperCase(),
            style: GoogleFonts.newsCycle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/fundo-futebol-retro-preto.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.yellow,
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50.h),
                    width: 800.w,
                    height: 150.h,
                    //color: Colors.yellow,
                    child: Center(
                      child: GradientText(
                        'TABELA DE CLASSIFICAÇÃO',
                        shaderRect: Rect.fromLTWH(0.0, 0.0, 30.0, 70.0),
                        gradient: Gradients.buildGradient(
                            Alignment.topCenter,
                            Alignment.center,
                            [Colors.grey.shade800, Colors.white]),
                        softWrap: true,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(200, 0, 200, 50),
                    color: Colors.transparent.withOpacity(0.3),
                    child: Table(
                      defaultColumnWidth: FlexColumnWidth(2),
                      children: recuperaLinhasTabela(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                                left: 60.w,
                                top: 30.h,
                                right: 60.w,
                                bottom: 30.h),
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Voltar',
                            style: GoogleFonts.roboto(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                                left: 60.w,
                                top: 30.h,
                                right: 60.w,
                                bottom: 30.h),
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
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
                            'Sair',
                            style: GoogleFonts.roboto(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
