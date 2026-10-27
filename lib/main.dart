import 'package:flutter/material.dart';

class Pet {
  final String nome;
  final String especie;
  final int idade;
  final bool eCastrado;

  Pet({
    required this.nome,
    required this.especie,
    required this.idade,
    required this.eCastrado,
  });
}

void main() => runApp(const MaterialApp(home: FormularioExemplo()));

class FormularioExemplo extends StatefulWidget {
  const FormularioExemplo({super.key});
 
  @override
  State<FormularioExemplo> createState() => _FormularioExemploState();
}

class _FormularioExemploState extends State<FormularioExemplo> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  String? _especieSelecionada;
  bool _animalCastrado = false;

  void _cadastrarPet(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final pet = Pet(
        nome: _nomeController.text,
        especie: _especieSelecionada!,
        idade: int.parse(_idadeController.text),
        eCastrado: _animalCastrado,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PerfilPetPage(pet: pet),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
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
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Pet',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Insira o nome!' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _especieSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Espécie',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Cachorro', child: Text('Cachorro')),
                  DropdownMenuItem(value: 'Gato', child: Text('Gato')),
                  DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                ],
                onChanged: (value) {
                  setState(() {
                    _especieSelecionada = value;
                  });
                },
                validator: (value) => value == null ? 'Selecione a espécie!' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade do Pet (Em anos)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Insira a idade!';
                  if (int.tryParse(value) == null || int.parse(value) <= 0) return 'Idade inválida!';
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
                onPressed: () => _cadastrarPet(context), 
                child: const Text('Cadastrar Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PerfilPetPage extends StatelessWidget {
  final Pet pet; 

  const PerfilPetPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil de ${pet.nome}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' Nome: ${pet.nome}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(' Espécie: ${pet.especie}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text(' Idade: ${pet.idade} anos', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text(
                  ' Castrado: ${pet.eCastrado ? "Sim" : "Não"}', 
                  style: TextStyle(fontSize: 18, color: pet.eCastrado ? Colors.green : Colors.orange),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
