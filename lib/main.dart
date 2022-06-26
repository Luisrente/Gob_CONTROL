import 'package:flutter/material.dart';
import 'package:gobernacion/provider/provider.dart';
import 'package:gobernacion/routes/routes.dart';
import 'package:gobernacion/services/notications_service.dart';
import 'package:gobernacion/services/services.dart';
import 'package:gobernacion/ui/screen/screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPrefe().init();
  runApp(const AppState());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await UserPrefe().init();
//   runApp(const AppState());
// }

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CarnetService()),
        ChangeNotifierProvider(create: (_) => UserPrefe()),
        ChangeNotifierProvider(create: (_) => InputsDocumentForms()),
        ChangeNotifierProvider(create: (_) => JornadaServices()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  //  UserPrefe().init().then((){});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'check',
      routes: {
        'login': (_) => LoginPage(),
        'register': (_) => RegisterScreen(),
        'home': (_) => const HomeScreen(),
        'check': (_) => LoadingScreen(),
        'control': (_) => const ControlScreen(),
        'password': (_) => PasswordScreen(),
        'jordana': (_) => JornadaScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
