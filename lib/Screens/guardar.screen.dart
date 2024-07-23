import 'package:flutter/material.dart';
import 'package:war_20220037/services/firebase_service.dart';
// Asegúrate de importar el archivo adecuado

class AgregarVivencia extends StatefulWidget {
  const AgregarVivencia({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AgregarVivenciaState createState() => _AgregarVivenciaState();
}

class _AgregarVivenciaState extends State<AgregarVivencia> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Vivencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            ElevatedButton(
              onPressed: () {
                _guardarVivencia(); // Llama al método de Firebase Service
              },
              child: const Text('Guardar Vivencia'),
            ),
          ],
        ),
      ),
    );
  }

  void _guardarVivencia() async {
    String titulo = tituloController.text;
    String descripcion = descripcionController.text;

    if (titulo.isNotEmpty && descripcion.isNotEmpty) {
      try {
        await guardarVivencia(titulo, descripcion);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vivencia guardada con éxito'),
          ),
        );

        tituloController.clear();
        descripcionController.clear();
      } catch (error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar la vivencia: $error'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos'),
        ),
      );
    }
  }
}
