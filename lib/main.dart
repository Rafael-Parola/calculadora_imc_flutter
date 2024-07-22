import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 81, 255, 1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora de IMC'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  String resultadoImc = '';
  String imcCategoria = '';

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Calculadora de IMC',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
             const Text(
              '(Índice de massa corporal)',
              style: TextStyle(
                fontSize: 16,
               // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: controllerPeso,
                decoration: const InputDecoration(
                    labelText: "Peso *",
                    hintText: "Digite Seu Peso",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(16.0))))),
            const SizedBox(height: 16),
            TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: controllerAltura,
                decoration: const InputDecoration(
                    labelText: 'Altura *',
                    hintText: "Digite sua altura:",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(16.0))))),
            const SizedBox(
              height: 32,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        String pesoText =
                            controllerPeso.text.replaceAll(',', '.');
                        String alturaText =
                            controllerAltura.text.replaceAll(',', '.');

                        if (pesoText.isNotEmpty && alturaText.isNotEmpty) {
                          try {
                            num peso = num.parse(pesoText);
                            num altura = num.parse(alturaText);

                            if (peso > 0 && altura > 0) {
                              num numAux = peso / (altura * altura);
                              resultadoImc = numAux.toStringAsFixed(2);

                              if (numAux >= 18.6 && numAux <= 24.9) {
                                imcCategoria = 'Normal';
                              } else if (numAux <= 18.5) {
                                imcCategoria = 'Abaixo do normal';
                              } else if (numAux >= 25.0 && numAux <= 29.9) {
                                imcCategoria = 'Sobrepeso';
                              } else if (numAux >= 30.0 && numAux <= 34.9) {
                                imcCategoria = 'Obesidade grau I';
                              } else if (numAux >= 35.0 && numAux <= 39.9) {
                                imcCategoria = 'Obesidade grau II';
                              } else if (numAux >= 40.0) {
                                imcCategoria = 'Obesidade grau III';
                              }
                            } else {
                              resultadoImc = '';
                              imcCategoria =
                                  'Peso e altura devem ser maiores que zero';
                            }
                          } catch (e) {
                            resultadoImc = '';
                            imcCategoria =
                                'Entrada inválida. Certifique-se de inserir números válidos.';
                          }
                        } else {
                          resultadoImc = '';

                          imcCategoria = 'Por favor, preencha ambos os campos.';
                          
                        }

                        //---------------------------
                      });
                    },
                    child: const Text('Cliquei aqui', 
                    style: TextStyle(fontSize: 26),
                    
                    )
                    )
                    ),
            const SizedBox(height: 20),
            Text(
              'IMC: $resultadoImc',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Categoria: $imcCategoria',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            resultadoImc = '';
            controllerAltura.text = '';
            controllerPeso.text = '';
            imcCategoria = '';
            
          });
        },
        tooltip: 'Increment',
        child: Text('Limpar'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
