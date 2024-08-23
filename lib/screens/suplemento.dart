import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importação para autenticação

class Suplemento extends StatefulWidget {
  const Suplemento({super.key});

  @override
  State<Suplemento> createState() => _SuplementoState();
}

class _SuplementoState extends State<Suplemento> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  


  void _adicionarSuplemento() async {
    // Obtendo os valores dos controladores
    String nome = _nomeController.text;
    String quantidade = _quantidadeController.text;
    String descricao = _descricaoController.text;
    String data = _dataController.text;
    String hora = _horaController.text;

    // Obtendo o UID do usuário autenticado
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Se o usuário não estiver autenticado, mostre uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você precisa estar logado para adicionar um suplemento')),
      );
      return;
    }
    String userId = user.uid;

    // Validando se todos os campos estão preenchidos
    if (quantidade.isNotEmpty && descricao.isNotEmpty && data.isNotEmpty && hora.isNotEmpty) {
      // Criando uma instância do Firestore
      final firestore = FirebaseFirestore.instance;

      // Adicionando os dados no Firestore
      await firestore.collection('users').doc(userId).collection('suplementos').add({
        'nome': nome,
        'userId': userId, // Adiciona o UID do usuário
        'quantidade': quantidade,
        'descricao': descricao,
        'data': data,
        'hora': hora,
      });

      // Navegando para a página desejada após adicionar os dados
      Navigator.pushNamed(context, '/homepage');
    } else {
      // Mostra uma mensagem de erro se algum campo estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
    }
  }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Suplemento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: "Nome suplemento",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String name) {
                // Aqui você pode definir a lógica para atualizar o estado, se necessário
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _quantidadeController,
                    decoration: const InputDecoration(
                      labelText: "Quantidade",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      labelText: "Descrição (e.g., comprimido, cápsula)",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _dataController,
                    decoration: const InputDecoration(
                      labelText: "Data",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _dataController.text =
                              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _horaController,
                    decoration: const InputDecoration(
                      labelText: "Hora",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        setState(() {
                          _horaController.text = pickedTime.format(context);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Chame a lógica de adicionar suplemento e navegue
                    _adicionarSuplemento();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 206, 7, 34), // Cor do botão
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  ),
                  child: Text(
                    'Adicionar',
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
          ],
        ),
      ),
    );
  }
}
