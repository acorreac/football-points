import 'package:football_points/classes/estado_partida.dart';

import 'jogo.dart';

class DadosTabela {
  String nome = '';
  int vitorias = 0;
  int empates = 0;
  int derrotas = 0;

  DadosTabela(String nome) {
    this.nome = nome;
  }

  void somaVitoria() {
    this.vitorias += 1;
  }

  void somaEmpate() {
    this.empates += 1;
  }

  void somaDerrotas() {
    this.derrotas += 1;
  }

  int recuperaPontosTotais() {
    return (this.vitorias * 3) + this.empates;
  }

  String recuperaNomeTime() {
    return this.nome;
  }
}

class ResultadosPorTime {
  Map<String, DadosTabela> _dadosDosTimes = Map();

  ResultadosPorTime(List<String> times) {
    times.forEach((time) {
      _dadosDosTimes.putIfAbsent(time, () {
        return new DadosTabela(time);
      });
    });
  }

  List<DadosTabela> recuperaDadosTimes() {
    return _dadosDosTimes.values.toList();
  }

  void computa(Jogo jogo) {
    String time = jogo.time;
    EstadoPatida resultado = jogo.resultado;
    DadosTabela dadosDoTime = DadosTabela('');
    if (_dadosDosTimes.containsKey(time)) {
      dadosDoTime = _dadosDosTimes[time]!;
    }

    if (resultado == EstadoPatida.empatou) {
      dadosDoTime.somaEmpate();
    } else if (resultado == EstadoPatida.ganhou) {
      dadosDoTime.somaVitoria();
    } else if (resultado == EstadoPatida.perdeu) {
      dadosDoTime.somaDerrotas();
    }
  }
}
