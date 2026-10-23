import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FormularioExemplo()));

class FormularioExemplo extends StatefulWidget {
  const FormularioExemplo({super.key});
 
  @override
  State<FormularioExemplo> createState() => _FormularioExemploState();
}

class _FormularioExemploState extends State<FormularioExemplo> {
  final _formKey = GlobalKey<FormState>();
  final _nomePetController = TextEditingController();
  final _idadeEmAnosController = TextEditingController();
  bool _animalCastrado = false;

  void _submeterFormulario() {
  if (_formKey.currentState!.validate()) {
    String nomePet = _nomePetController.text;
    String castradoTexto = _animalCastrado ? 'Sim' : 'Não';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cadastro do(a) $nomePet realizado! Castrado: $castradoTexto'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Rápido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomePetController,
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Nome do Pet',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                labelText: 'Espécie',
                border: OutlineInputBorder(),
                ),
                  items: const [
                   DropdownMenuItem(value: 'Cachorro', child: Text('Cachorro')),
                   DropdownMenuItem(value: 'Gato', child: Text('Gato')),
                   DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                ],
                  onChanged: (value) {},
                  validator: (value) => value == null ? 'Selecione a espécie!' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeEmAnosController,
                keyboardType: TextInputType.number,
                obscureText: false, 
                decoration: const InputDecoration(
                  labelText: 'Idade do Pet (Em anos)',
                  border: OutlineInputBorder(),
                ),
              validator: (value) {
                 if (value == null || value.isEmpty) {
                  return 'Por favor, insira a idade do pet!';
              }
                   final idade = int.tryParse(value);
                 if (idade == null || idade <= 0) {
                  return 'Insira uma idade válida!';
              }
                return null;
                },
              ),
              const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Seu animal é castrado?'),
              value: _animalCastrado, 
              onChanged: (bool? value) {
                setState(() {
                  _animalCastrado = value ?? false;
                });
              },
            ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submeterFormulario,
                child: const Text('Cadastrar Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}