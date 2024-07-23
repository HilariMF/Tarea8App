import 'package:flutter/material.dart';
import 'package:war_20220037/Screens/actualizar.screen.dart';
import 'package:war_20220037/Screens/borrar.screen.dart';
import 'package:war_20220037/Screens/contratame.dart';
import 'package:war_20220037/Screens/guardar.screen.dart';
import 'package:war_20220037/Screens/leer.screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 58, 55, 55),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text('Hilari Medina',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text('2022-1025',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              currentAccountPicture: CircleAvatar(
                child: Image.asset(
                  'lib/foto2x2.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  image: DecorationImage(
                    image: AssetImage('lib/estampado.jpg'),
                    fit: BoxFit.cover,
                  ))),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text('Inicio', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.white),
            title: const Text('Leer', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VivenciasList()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.save, color: Colors.white),
            title: const Text('Guardar', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AgregarVivencia()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.update, color: Colors.white),
            title:
                const Text('Actualizar', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActualizarVivencia()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.white),
            title: const Text('Borrar', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BorrarVivencia()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.white),
            title:
                const Text('Contratame', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Contratame()));
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
