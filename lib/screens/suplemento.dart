import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Suplemento extends StatefulWidget {
  const Suplemento({super.key});

  @override
  State<Suplemento> createState() => _SuplementoState();
}

class _SuplementoState extends State<Suplemento> {
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  String? name;
  String? descricao;
  double? quantidade;

  void getName(String name) {
    this.name = name;
  }

  void getDescricao(String descricao) {
    this.descricao = descricao;
  }

  void getQuantidade(String quantidadeStr) {
    // Converta a String para double e atribua à variável
    double? quantidade = double.tryParse(quantidadeStr);
    this.quantidade = quantidade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Suplemento"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
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
                getName(name); // Ação ao alterar o texto
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                    onChanged: (String quantidade) {
                      getQuantidade(quantidade); // Ação ao alterar a quantidade
                    },
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
                    onChanged: (String descricao) {
                      getDescricao(descricao); // Ação ao alterar a descrição
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
          ),
          
        ],
      ),
    );
  }
}
