import 'package:football_points/classes/jogo.dart';

class ListaDeJogos {
  static ListaDeJogos? _intancia;

  List<Jogo> _jogos = [];

  static getInstance() {
    if (_intancia == null) {
      _intancia = new ListaDeJogos();
    }
    return _intancia;
  }

  void adicionaJogo(Jogo jogo) {
    _jogos.add(jogo);
  }

  List<Jogo> recuperaJogos() {
    return this._jogos;
  }
}
