import 'package:flutter/material.dart';
import 'package:gobernacion/services/services.dart';
import 'package:gobernacion/ui/screen/screen.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';

// import 'package:chat/services/socket_service.dart';
// import 'package:chat/services/auth_service.dart';

// import 'package:chat/pages/login_page.dart';
// import 'package:chat/pages/usuarios_page.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    // final authService = Provider.of<AuthService>(context, listen: false);
    // final socketService = Provider.of<SocketService>( context, listen: false );
    final prefe = Provider.of<UserPrefe>(context, listen: false);

    final bool autenticado = await prefe.loggin();

    Usuario dato = Usuario();
    // log('---->${autenticado}');
    print('kdkdkkdkd');
    print(autenticado);
    print('mxmxmxmmxm');

    if (autenticado == false) {
      // socketService.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      dato = await prefe.getUserInfo();
      if (dato.estado == 'false') {
        // socketService.connect();
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => PasswordScreen(),
                transitionDuration: const Duration(milliseconds: 0)));
      }

      if (dato.rol == 'USER_ROLE') {
        // socketService.connect();
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const HomeScreen(),
                transitionDuration: const Duration(milliseconds: 0)));
      }

      if (dato.rol == 'ADMIN_ROLE') {
        // socketService.connect();
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ControlScreen(),
                transitionDuration: const Duration(milliseconds: 0)));
      }
    }
  }
}
