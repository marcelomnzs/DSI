import 'package:app_dsi/components/CustomRoundedIconButton.dart';
import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/screens/RegisterPage.dart';
import 'package:app_dsi/screens/Splash.dart';
import 'package:app_dsi/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 30),
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
                  'Login',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            SizedBox(
              child: Text(
                'E-mail:',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email_rounded),
                hintText: 'Digite o seu endereço de e-mail',
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                child: Text(
                  'Senha:',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const Column(
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: '**************',
                    hintStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Splash()),
                      );
                    },
                    child: Text(
                      'Esqueci minha senha',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 6),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      color: lightColorScheme.primary,
                      borderRadius: BorderRadius.circular(34)),
                  child: Text(
                    'Login',
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
            // const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
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
            // const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Ou faça login com',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoundedIconButton(
                    imagePath: 'assets/images/google-logo.png'),
                SizedBox(
                  width: 23,
                ),
                CustomRoundedIconButton(
                    imagePath: 'assets/images/facebook-logo.png')
              ],
            )
          ],
        ),
      ),
    );
  }
}
