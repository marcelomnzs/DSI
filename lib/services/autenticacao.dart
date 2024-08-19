import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  cadastrarUsuario({
    required String nome,
    required String senha,
    required String email,
  }) {
    _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<String?> logarUsuario({required String email, required senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
// Método para logar um usuário com Google
  Future<UserCredential?> logarComGoogle() async {
    try {
      // Faz o login com a conta do Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // Se o usuário cancelar o login
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Cria uma credencial do Firebase com o token do Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Loga o usuário no Firebase com a credencial do Google
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Erro ao logar com Google: ${e.message}');
      return null;
    }
  }


}
