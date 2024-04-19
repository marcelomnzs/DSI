import 'package:app_dsi/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_dsi/core/theme/color_schemes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30), // Adicionado espaço acima da imagem
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.9,
                widthFactor: 1,
                child: SvgPicture.asset(
                  'assets/svg/running-man-data.svg',
                ),
              ),
            ),
            SizedBox(height: 20), // Aumentado o espaço abaixo da imagem
            Text(
              'Cadastro',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 20), // Adicionado espaço após o texto 'Cadastro'
            Text(
              'Nome:',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                hintText: 'Digite o seu nome',
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10), // Adicionado espaço após o campo 'Nome'
            Text(
              'Email:',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email),
                hintText: 'Digite seu endereço de e-mail',
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10), // Adicionado espaço após o campo 'Email'
            Text(
              'Senha:',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: '********',
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10), // Adicionado espaço após o campo 'Senha'
            Text(
              'Confirmar Senha:',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: '********',
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20), // Adicionado espaço após os campos de senha
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: lightColorScheme.primary,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Text(
                    'Cadastrar-se',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Aumentado o espaço após o botão de cadastro
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Já possui uma conta? Faça login',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Aumentado o espaço após o texto de login
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
