import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:war_20220037/services/firebase_service.dart';


class BorrarVivencia extends StatefulWidget {
  const BorrarVivencia({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BorrarVivenciaState createState() => _BorrarVivenciaState();
}

class _BorrarVivenciaState extends State<BorrarVivencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrar Vivencias'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: obtenerVivencias(),
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
                        mostrarConfirmacionBorrado(vivencia);
                      },
                      child: const Text('Borrar'),
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

  void mostrarConfirmacionBorrado(QueryDocumentSnapshot vivencia) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Borrado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('¿Seguro que deseas borrar esta vivencia?'),
              Text('Título: ${vivencia['Titulo']}'),
              Text('Descripción: ${vivencia['Descripcion']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                eliminarVivencia(vivencia.id);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Confirmar Borrado'),
            ),
          ],
        );
      },
    );
  }
}
