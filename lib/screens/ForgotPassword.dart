import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/screens/Splash.dart';
import 'package:app_dsi/services/autenticacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FractionallySizedBox(
                    heightFactor: 0.9,
                    widthFactor: 1,
                    child: SvgPicture.asset(
                      'assets/svg/running-people.svg',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                  height: 50,
                  child: Text(
                    'Recuperar senha',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email),
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
                    final emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                ),
              ),
              // Adicionando um SizedBox para o espaçamento
              SizedBox(height: 20), // Ajuste a altura conforme necessário
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Lógica para redefinir senha ainda está em desenvolvimento
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Função de redefinir senha em desenvolvimento'),
                    ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                        color: lightColorScheme.primary,
                        borderRadius: BorderRadius.circular(34)),
                    child: Text(
                      'Enviar',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Splash(nextRoute: '/registerpage'),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Não possui conta? Cadastre-se',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
