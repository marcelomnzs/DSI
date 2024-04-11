import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       color: Color.fromARGB(255, 224, 84, 84),// cor escolhida
      child: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children:[
            Text(
              'MYHEART',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 20.0), // Espaço entre o texto e o indicador de progresso
          CircularProgressIndicator(), // Indicador de progresso
          ],
        ),
      )
    )
   );
  }
}