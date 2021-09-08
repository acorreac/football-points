import 'dart:convert';

import 'package:http/http.dart' as http;

class ListaTimes {
  static List<String> _carregaNomeTimes(String responseBody) {
    List<String> listaDeTimes = [''];
    List<dynamic> dadosDosTimes = json.decode(responseBody);
    dadosDosTimes.forEach((dadoTime) {
      listaDeTimes.add(dadoTime['time']['nome_popular']);
    });
    return listaDeTimes;
  }

  static Future<List<String>> recuperaListaDeTimes() async {
    List<String> listaDeTimes = [];
    String token = 'test_e7deb0887bf6c9146cc540149b4ea7';
    String url = 'https://api.api-futebol.com.br/v1/campeonatos/2/tabela';
    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      listaDeTimes = _carregaNomeTimes(response.body);
    } else {
      listaDeTimes.add('Corinthians');
      listaDeTimes.add('São Paulo');
      listaDeTimes.add('Cruzeiro');
    }
    return listaDeTimes;
  }
}
