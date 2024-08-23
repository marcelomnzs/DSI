import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarSuplementos extends StatefulWidget {
  final DocumentSnapshot suplemento;

  const EditarSuplementos({Key? key, required this.suplemento}) : super(key: key);
  
  @override
  _EditarSuplementoState createState() => _EditarSuplementoState();
}

class _EditarSuplementoState extends State<EditarSuplementos> {
  late TextEditingController _nomeController;
  late TextEditingController _quantidadeController;
  late TextEditingController _descricaoController;
  late TextEditingController _dataController;
  late TextEditingController _horaController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.suplemento['nome']);
    _quantidadeController = TextEditingController(text: widget.suplemento['quantidade']);
    _descricaoController = TextEditingController(text: widget.suplemento['descricao']);
    _dataController = TextEditingController(text: widget.suplemento['data']);
    _horaController = TextEditingController(text: widget.suplemento['hora']);
  }

  void _editarSuplemento() async {
    // Atualiza os dados no Firestore
    await widget.suplemento.reference.update({
      'quantidade': _quantidadeController.text,
      'descricao': _descricaoController.text,
      'data': _dataController.text,
      'hora': _horaController.text,
    });

    // Volta para a tela anterior
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Suplemento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _quantidadeController,
              decoration: const InputDecoration(labelText: "Quantidade"),
            ),
            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            TextFormField(
              controller: _dataController,
              decoration: const InputDecoration(labelText: "Data"),
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
            TextFormField(
              controller: _horaController,
              decoration: const InputDecoration(labelText: "Hora"),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editarSuplemento,
              child: const Text("Salvar Alterações"),
            ),
          ],
        ),
      ),
    );
  }
}
