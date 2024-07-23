import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVivencias() async {
  List vivencias = [];

  CollectionReference collectionReferenceVivencias = db.collection('Vivencias');
  QuerySnapshot queryVivencias = await collectionReferenceVivencias.get();

  for (var documento in queryVivencias.docs) {
    vivencias.add(documento.data());
  }

  return vivencias;
}

Future<void> guardarVivencia(String titulo, String descripcion) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference vivencias = firestore.collection('Vivencias');

  try {
    await vivencias.add({
      'Titulo': titulo,
      'Descripcion': descripcion,
      'Fecha': FieldValue.serverTimestamp(),
    });
  } catch (error) {
    throw ('Error al guardar la vivencia en Firebase: $error');
  }
}

Future<QuerySnapshot> obtenerVivencias() async {
  return FirebaseFirestore.instance.collection('Vivencias').get();
}

Future<void> eliminarVivencia(String vivenciaId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('Vivencias').doc(vivenciaId).delete();
  } catch (error) {
    throw ('Error al eliminar la vivencia en Firebase: $error');
  }
}

