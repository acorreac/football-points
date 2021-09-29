class Time {
  String nome;
  String escudo;

  Time({required this.nome, required this.escudo});

  static Time toTimeSemEscudo(String nome) {
    return Time(nome: nome, escudo: '');
  }

  @override
  String toString() {
    return 'Time: $nome\nEscudo: $escudo';
  }
}
