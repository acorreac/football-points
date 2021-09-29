import 'dart:convert';

import 'package:football_points/classes/time.dart';
import 'package:http/http.dart' as http;

class ListaTimes {
  static List<Time> _carregaNomeTimes(String responseBody) {
    List<Time> listaDeTimes = [Time.toTimeSemEscudo('')];
    List<dynamic> dadosDosTimes = json.decode(responseBody);
    dadosDosTimes.forEach((dynamic dadoTime) {
      String nome = dadoTime['time']['nome_popular'];
      String escudo = dadoTime['time']['escudo'];
      listaDeTimes.add(Time(nome: nome, escudo: escudo));
    });
    return listaDeTimes;
  }

  static Future<List<Time>> recuperaListaDeTimes() async {
    List<Time> times = [];
    String token = 'test_e7deb0887bf6c9146cc540149b4ea7';
    String url = 'https://api.api-futebol.com.br/v1/campeonatos/2/tabela';
    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      times = _carregaNomeTimes(response.body);
    } else {
      times.add(Time.toTimeSemEscudo(''));
      times.add(Time.toTimeSemEscudo('Corinthians'));
      times.add(Time.toTimeSemEscudo('São Paulo'));
      times.add(Time.toTimeSemEscudo('Cruzeiro'));
    }
    return times;
  }
}
