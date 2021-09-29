import 'package:football_points/classes/estado_partida.dart';
import 'package:football_points/classes/time.dart';

class Jogo {
  Time time = Time(nome: '', escudo: '');
  EstadoPartida resultado = EstadoPartida.naoSelecionado;

  Jogo({required this.time, required this.resultado});

  @override
  String toString() {
    return 'Time: $time\nResultado: $resultado';
  }
}
