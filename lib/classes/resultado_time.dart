import 'package:football_points/classes/estado_partida.dart';
import 'package:football_points/classes/time.dart';

import 'jogo.dart';

class DadosTabela {
  String nome = '';
  String escudo = '';
  int vitorias = 0;
  int empates = 0;
  int derrotas = 0;

  DadosTabela({required this.nome, required this.escudo});

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
  Map<Time, DadosTabela> _dadosDosTimes = Map();

  ResultadosPorTime(List<Time> times) {
    times.forEach((time) {
      _dadosDosTimes.putIfAbsent(time, () {
        return new DadosTabela(nome: time.nome, escudo: time.escudo);
      });
    });
  }

  List<DadosTabela> recuperaDadosTimes() {
    return _dadosDosTimes.values.toList();
  }

  void computa(Jogo jogo) {
    Time time = jogo.time;
    EstadoPartida resultado = jogo.resultado;
    DadosTabela dadosDoTime = DadosTabela(nome: '', escudo: '');
    if (_dadosDosTimes.containsKey(time)) {
      dadosDoTime = _dadosDosTimes[time]!;
    }

    if (resultado == EstadoPartida.empatou) {
      dadosDoTime.somaEmpate();
    } else if (resultado == EstadoPartida.ganhou) {
      dadosDoTime.somaVitoria();
    } else if (resultado == EstadoPartida.perdeu) {
      dadosDoTime.somaDerrotas();
    }
  }
}
