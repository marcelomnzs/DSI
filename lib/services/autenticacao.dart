import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
}
