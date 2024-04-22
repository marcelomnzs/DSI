import 'package:app_dsi/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_dsi/core/theme/color_schemes.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>(); 


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
            SizedBox( // Adicionado espaço após o texto 'Cadastro'
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                labelText: 'Nome',
                hintText: 'Digite seu nome',
                labelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    ),
                  ),
                ),
              validator: (String? value) {
                    if (value == null) {
                      return 'O campo não pode ser vazio';
                    }
                    return null;
                  },           
              ),
            ),
            SizedBox(        
              child: TextFormField(
                decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email),
                labelText: 'Email',
                hintText: 'Digite seu email',
                labelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    ),
                  ),
                ),
              validator: (String? value) {
                if (value == null) {
                  return 'O campo não pode ser vazio';
                }
                if (value.length < 5) {
                  return 'O email é invalido';
                }
                if (!value.contains('@')) {
                  return 'Email invalido';
                }
                if (!value.contains('.com')) {
                  return 'Email invalido';
                }
                return null;
               },   
              ),
            ),
            SizedBox( 
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Senha',
              hintText: '********',
              labelStyle:GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                      ),
                    ),
                  ),
            obscureText: true,              
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, confirme sua senha';
              }
              if (value != _passwordController.text) {
                return 'A senha deve conter 6 caracteres';
              }
                return null;
              },
              ),
            ),
            SizedBox( // Adicionado espaço após o campo 'Senha'
            child: TextFormField(
              decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Confirmar senha',
              hintText: '********',
              labelStyle:GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                      ),
                    ),
                  ),
            obscureText: true,              
            validator: (String? value) {
              if (value == null) {
                return 'A senha não pode ser vazia';
              }
              if (value.length < 6) {
                return 'A senha deve conter 6 caracteres';
              }
              if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                return 'A senha deve conter pelo menos uma letra';
              }
              if (!value.contains(RegExp(r'[0-9]'))) { 
                return 'A senha deve conter pelo menos um numero';
              }
                return null;
              },
              ),
            ),
            SizedBox(height: 20), // Adicionado espaço após os campos de senha
            Center(
              child: GestureDetector(
                onTap: () 
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
