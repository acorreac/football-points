import 'package:football_points/classes/jogo.dart';

class ListaDeJogos {
  static ListaDeJogos? _instancia;

  List<Jogo> _jogos = [];

  static getInstance() {
    if (_instancia == null) {
      _instancia = new ListaDeJogos();
    }
    return _instancia;
  }

  void adicionaJogo(Jogo jogo) {
    _jogos.add(jogo);
  }

  List<Jogo> recuperaJogos() {
    return this._jogos;
  }
}
