import 'package:flutter/material.dart';
import 'package:gobernacion/helpers/show_alert.dart';
import 'package:gobernacion/services/services.dart';
import 'package:gobernacion/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // const Logo(titulo: 'Control Acceso'),
                  _Form(),
                  const Labels(
                    ruta: 'register',
                    titulo: '¿Eres visitante ? ¿No tienes cuenta?',
                    subTitulo: 'Crea una ahora!',
                  ),
                  const Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Logo(
              titulo:
                  'Bienvenido a la aplicacion de control de la gobernacion de cordoba'),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          Boton(
            text: 'Ingrerse',
            // onPressed: () {
            //   // Navigator.pushReplacementNamed(context, 'register');
            //   print('fkfkkfkfkf');
            //   print(emailCtrl.text);
            //   print(passCtrl.text);
            // },
            onPressed: authService.autenticando
                ? () => {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                      // TODO: Conectar a nuestro socket server
                      Navigator.pushReplacementNamed(context, 'check');
                    } else {
                      // Mostara alerta
                      return mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus credenciales nuevamente');
                    }
                  },
          )
        ],
      ),
    );
  }
}
