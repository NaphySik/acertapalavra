
import 'dart:math';

import 'package:flutter/material.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  _Homepage1State createState() => _Homepage1State();
}

class _Homepage1State extends State {
  final Map<String, List<String>> _palavradicas = {
  'maça' :["É uma fruta", "Sua cor é vermelha","Se encontra em árvores"],
  'nariz' : ["Uma parte do corpo", "Por onde se faz a respiração","Faz parte do rosto", "está acima da boca"],
  'carro' : ["Veículo", "Possui quatro rodas", "Possui motor"],
  'gato' : ["Possui uma famosa inimizade com o cachorro", "Tem fama de ter coração frio","Geralmente tem pelos", "Animal de estimação"],
};

TextEditingController _palavraController = TextEditingController();

void _sortearPalavra() {
  final random = Random();
  final palavras = _palavradicas.keys.toList();
  final sorteada = palavras[random.nextInt(palavras.length)];

  setState(() {
    _palavraAtual = sorteada;
    _dicasAtuais = _palavradicas[sorteada];
    _dicaIndex = 0;
    _mensagem = null;
  });
}

void _verificarResposta() {
  final resposta = _palavraController.text.trim().toLowerCase();

  if (resposta == _palavraAtual) {
    setState(() {
      _mensagem = 'Parabéns! Você acertou.';
    });
    Future.delayed(Duration(seconds: 2), () {
      _sortearPalavra();
      _palavraController.clear();
    });
  } else {
    if (_dicaIndex < (_dicasAtuais!.length - 1)) {
      _dicaIndex++;
    }
    Navigator.pushNamed(
      context,
      '/homepage2',
      arguments: {
        'dica': _dicasAtuais![_dicaIndex],
        'mensagem': 'Você errou. Tente novamente!',
      },
    );
  }
}

String? _palavraAtual;
List<String>? _dicasAtuais;
int _dicaIndex = 0;
String? _mensagem;

  @override
  void initState() {
    super.initState();
    _sortearPalavra();
  }

  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('App Acerta Palavra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _palavraController,
                decoration: InputDecoration(
                    labelText: 'Adivinhe a palavra',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.device_unknown_rounded)),
                onFieldSubmitted: (String value) {
                  print(value);
                },),
              SizedBox(height: 32,),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.blue),
                            foregroundColor: WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed: (){
                            setState(() {
                              _mensagem = _dicasAtuais![_dicaIndex];
                            });
                          },
                          child: Text('Dica')),
                      SizedBox(height: 32, width: 100),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.blue),
                            foregroundColor: WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed:_verificarResposta,
                          child: Text('Verificar Resposta'),
                      ),
                      if (_mensagem != null) ...[
                        Text(
                          _mensagem!,
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      ],
                    ],
                  ),
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}