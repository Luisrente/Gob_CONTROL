import 'package:flutter/material.dart';

import 'package:gobernacion/ui/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // const Logo(titulo: 'Registro de visitantes '),
                  _Form(),
                  const Labels(
                    ruta: 'login',
                    titulo: '¿Ya tienes una cuenta?',
                    subTitulo: 'Ingresa ahora!',
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          const Logo(titulo: 'Introduce los nombres y apellidos'),
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Primer Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Segundo Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: ' Primer Apellido',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Segundo Apellido',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          // CustomInput(
          //   icon: Icons.mail_outline,
          //   placeholder: 'Correo',
          //   keyboardType: TextInputType.emailAddress,
          //   textController: emailCtrl,
          // ),
          // CustomInput(
          //   icon: Icons.lock_outline,
          //   placeholder: 'Contraseña',
          //   textController: passCtrl,
          //   isPassword: true,
          // ),
          Boton(
            text: 'Continuar ',
            onPressed: () {
              // Navigator.pushReplacementNamed(context, 'register');
              print('fkfkkfkfkf');
              print(emailCtrl.text);
              print(passCtrl.text);
            },
            // onPressed: authService.autenticando
            //     ? () => {}
            //     : () async {
            //         FocusScope.of(context).unfocus();
            //         final loginOk = await authService.login(
            //             emailCtrl.text.trim(), passCtrl.text.trim());
            //         if (loginOk) {
            //           // TODO: Conectar a nuestro socket server
            //           Navigator.pushReplacementNamed(context, 'check');
            //         } else {
            //           // Mostara alerta
            //           return mostrarAlerta(context, 'Login incorrecto',
            //               'Revise sus credenciales nuevamente');
            //         }
            //       },
          )
        ],
      ),
    );
  }
}
