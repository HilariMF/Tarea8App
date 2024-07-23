import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:war_20220037/services/firebase_service.dart'; 

class VivenciasList extends StatefulWidget {
  const VivenciasList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VivenciasListState createState() => _VivenciasListState();
}

class _VivenciasListState extends State<VivenciasList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vivencias'),
      ),
      body: FutureBuilder<List>(
        future: getVivencias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List vivencias = snapshot.data ?? [];

            return ListView.builder(
              itemCount: vivencias.length,
              itemBuilder: (context, index) {
                return VivenciaCard(
                  titulo: vivencias[index]['Titulo'],
                  fecha: vivencias[index]['Fecha'] as Timestamp,
                  descripcion: vivencias[index]['Descripcion'],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class VivenciaCard extends StatelessWidget {
  final String titulo;
  final Timestamp fecha;
  final String descripcion;

  const VivenciaCard({
    super.key,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    // Formatear el Timestamp en una cadena legible
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(fecha.toDate());

    return Card(
      child: ListTile(
        title: Text(titulo),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(formattedDate),
            Text(descripcion),
          ],
        ),
      ),
    );
  }
}
