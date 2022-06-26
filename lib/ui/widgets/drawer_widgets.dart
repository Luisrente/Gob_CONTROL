import 'package:flutter/material.dart';
import 'package:gobernacion/ui/screen/screen.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/services.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefe = Provider.of<UserPrefe>(context, listen: false);
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(),
          DrawerNavigationItem(
            iconData: Icons.device_hub_rounded,
            title: "Control asistencia",
            selected: false,
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const JornadaScreen(),
                      transitionDuration: const Duration(seconds: 0)));
            },
          ),
          DrawerNavigationItem(
              iconData: Icons.dark_mode_outlined,
              title: "Salir ",
              selected: false,
              onTap: () async {
                await prefe.logout();
                //  Navigator.pushReplacementNamed(context, 'login');
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginPage(),
                        transitionDuration: const Duration(seconds: 0)));
              }),
        ],
      ),
    );
  }
}

class DrawerNavigationItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool selected;
  final Function() onTap;
  const DrawerNavigationItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      leading: Icon(iconData),
      onTap: onTap,
      title: Text(title),
      selectedTileColor: Colors.blueAccent.shade100,
      selected: selected,
      selectedColor: Colors.black87,
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carnetservice = Provider.of<CarnetService>(context);

    final prefe = UserPrefe();
    Usuario local = Usuario();
    carnetservice.loadCartUser();
    local = carnetservice.usuario;
    //  local = await prefe.getUserInfo();

    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 220,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/persona.jpeg'),
              ),
            ),
          ),
          Text(
            '${local.nombre1} ${local.apellido1}',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            ' ${local.correo}',
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
