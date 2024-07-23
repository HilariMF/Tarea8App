import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActualizarVivencia extends StatelessWidget {
  const ActualizarVivencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Vivencias'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Vivencias').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay vivencias disponibles.'));
          } else {
            final vivencias = snapshot.data!.docs;
            return ListView.builder(
              itemCount: vivencias.length,
              itemBuilder: (context, index) {
                final vivencia = vivencias[index];
                final titulo = vivencia['Titulo'];
                final descripcion = vivencia['Descripcion'];

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(titulo),
                    subtitle: Text(descripcion),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ActualizarVivenciaPage(vivencia: vivencia),
                          ),
                        );
                      },
                      child: const Text('Actualizar'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ActualizarVivenciaPage extends StatefulWidget {
  final QueryDocumentSnapshot vivencia;

  const ActualizarVivenciaPage({Key? key, required this.vivencia})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ActualizarVivenciaPageState createState() => _ActualizarVivenciaPageState();
}

class _ActualizarVivenciaPageState extends State<ActualizarVivenciaPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tituloController.text = widget.vivencia['Titulo'];
    descripcionController.text = widget.vivencia['Descripcion'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Vivencia'),
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
                actualizarVivencia();
              },
              child: const Text('Actualizar Vivencia'),
            ),
          ],
        ),
      ),
    );
  }

  void actualizarVivencia() async {
    String nuevoTitulo = tituloController.text;
    String nuevaDescripcion = descripcionController.text;

    if (nuevoTitulo.isNotEmpty && nuevaDescripcion.isNotEmpty) {
      final vivenciaId = widget.vivencia.id;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        await firestore.collection('Vivencias').doc(vivenciaId).update({
          'Titulo': nuevoTitulo,
          'Descripcion': nuevaDescripcion,
          'Fecha': FieldValue.serverTimestamp(),
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vivencia actualizada con éxito'),
          ),
        );

        // ignore: use_build_context_synchronously
        Navigator.pop(context); // Vuelve a la pantalla de ver vivencias
      } catch (error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar la vivencia: $error'),
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

