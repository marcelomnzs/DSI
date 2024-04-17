import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
   const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 226, 223, 223), // cor escolhida
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/Heart.svg', // Ícone
                  ),
                  SizedBox(width: 8), // Espaço entre o ícone e o texto
                  Text(
                    'MYHEART',
                    style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SizedBox(height: 20.0), // Espaço entre as linhas
              CircularProgressIndicator(), // Indicador de progresso
            ],
          ),
        ),
      ),
    );
  }
}
