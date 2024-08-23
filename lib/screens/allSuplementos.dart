import 'package:app_dsi/screens/editarSuplemento.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllSuplementos extends StatelessWidget {
  const AllSuplementos({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Obtém o UID do usuário autenticado
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Suplementos"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('suplementos')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum suplemento encontrado.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot suplemento = snapshot.data!.docs[index];

              return ListTile(
                title: Text(suplemento['nome']),
                subtitle: Text(
                    'Quantidade: ${suplemento['quantidade']}\nDescricao: ${suplemento['descricao']}\nData: ${suplemento['data']}\nHora: ${suplemento['hora']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Navega para a tela de edição passando os dados do suplemento
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarSuplementos(suplemento: suplemento),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Deleta o suplemento
                        suplemento.reference.delete();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
