import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Método para cadastrar um novo usuário com e-mail e senha
  Future<void> cadastrarUsuario({
    required String nome,
    required String senha,
    required String email,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } on FirebaseAuthException catch (e) {
      print('Erro ao cadastrar usuário: ${e.message}');
    }
  }

  // Método para logar um usuário com e-mail e senha
  Future<String?> logarUsuario({required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Método para logar um usuário com Google
  Future<UserCredential?> logarComGoogle() async {
    try {
      print('Iniciando autenticação com Google');

      // Faz o login com a conta do Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('O usuário cancelou a autenticação.');
        return null; // Usuário cancelou o login
      }

      // Obtém a autenticação do Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Cria uma credencial do Firebase com o token do Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Loga o usuário no Firebase com a credencial do Google
      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('Erro ao autenticar com Google: ${e.message}');
      return null;
    }
  }
}
