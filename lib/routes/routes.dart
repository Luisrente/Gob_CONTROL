import 'package:flutter/material.dart';
import 'package:gobernacion/ui/screen/screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  // 'usuarios': ( _ ) => UsuariosPage(),
  // 'chat'    : ( _ ) => ChatPage(),
  'login': (_) => LoginPage(),
  // 'register': ( _ ) => RegisterPage(),
  // 'loading' : ( _ ) => LoadingPage(),
};
