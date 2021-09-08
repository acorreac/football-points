import 'package:football_points/classes/estado_partida.dart';

class Jogo {
  String time = '';
  EstadoPatida resultado = EstadoPatida.na;

  Jogo(String time, EstadoPatida resultado) {
    this.time = time;
    this.resultado = resultado;
  }

  @override
  String toString() {
    return 'Time: $time\nResultado: $resultado';
  }
}
