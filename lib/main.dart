import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, //Define o tema azul para o aplicativo
        scaffoldBackgroundColor:
            Colors.lightBlue[50], //Funde da tela em azul claro
      ),
      home:
          const StepCounterScreen(), //Define a tela inicial como 'StepCounter'
    );
  }
}

class StepCounterScreen extends StatefulWidget {
  const StepCounterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StepCounterScreenState createState() => _StepCounterScreenState(); // Cria o estado da tela
}

// Estado da tela, onde acontece a lógica de contar os passos
class _StepCounterScreenState extends State<StepCounterScreen> {
  String _stepCountValue = '0';

  @override
  void initState() {
    super.initState();
    // Inicializa o pedômetro para contar os passos
    Pedometer.stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    setState(() {
      _stepCountValue = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    setState(() {
      _stepCountValue =
          'Erro ao contar passos'; // Exibe mensagem de erro na interface
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contador de Passos')),
      body: Center(
        child: Text(
          'Passos: $_stepCountValue',
          style: TextStyle(fontSize: 24, color: Colors.blue[900]),
        ),
      ),
    );
  }
}
