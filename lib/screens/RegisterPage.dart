import 'package:app_dsi/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/services/autenticacao.dart'; // Verifique o caminho


class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();  
  final _formkey = GlobalKey<FormState>(); 
  

  AutenticacaoServico _autenticaServico = AutenticacaoServico();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form( 
          key: _formkey,
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
              controller: _nomeController,
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
                    if (value == null || value.isEmpty) {
                      return 'O campo não pode ser vazio';
                    }
                    return null;
                  },           
              ),
            ),
            SizedBox(        
              child: TextFormField(
                controller: _emailController,
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
                if (value == null || value.isEmpty) {
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
              if (value == null || value.isEmpty) {
                return 'Por favor, confirme sua senha';
              }
              if (value != _passwordController.text) {
                return 'Senha não confere';
              }
                return null;
              },
              ),
            ),
            SizedBox(height: 20), // Adicionado espaço após os campos de senha
            Center(
              child: GestureDetector(
                onTap: () {
                  botao();
                  // verificar formulario para proxima pagina
                  if(_formkey.currentState!.validate()) {
                    // se o formulario for valido, para proxima pagina 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => const HomePage()));
                   };
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
      ),
    );
  }
// para visualizar se os dados estão sendo recebidos corretamentes e mandar para o firestore
  botao() {
    String nome = _nomeController.text;
    String senha = _passwordController.text;
    String email = _emailController.text;

    if (_formkey.currentState!.validate()) {
      print('Cadastro válido');
      print('Email: ${_emailController.text}, Nome: ${_nomeController.text}, Senha: ${_passwordController.text}');
            _autenticaServico.cadastrarUsuario(nome: nome, senha: senha, email: email);
    } else {
      print('Inválido');
    }
  }



}
