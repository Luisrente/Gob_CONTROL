import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gobernacion/ui/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../provider/provider.dart';
import '../../services/services.dart';

class JornadaScreen extends StatelessWidget {
  const JornadaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefe = UserPrefe();
    double height = MediaQuery.of(context).size.height * 0.75;
    double padding = MediaQuery.of(context).size.width * 0.07;
    return Scaffold(
      appBar: AppBar(
          actions: [
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () async {
                      Usuario local = Usuario();
                      local = await prefe.getUserInfo();
                    }),
              ],
            ),
          ],
          title: Center(
            child: SizedBox(
              height: kToolbarHeight,
              child: Image.asset('assets/logo.png'),
            ),
          ),
          toolbarHeight: kToolbarHeight,
          backgroundColor: Colors.white,
          elevation: 1),
      body: const _targe(),

      // _EnableGpsMessage()

      //  _AccessButton()

      //  _targe(),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.gps_fixed,
          color: Colors.red,
        ));
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.gps_fixed,
          color: Colors.black,
        ));
  }
}

class _targe extends StatelessWidget {
  const _targe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carnetservice = Provider.of<CarnetService>(context);
    final jornadaServices = Provider.of<JornadaServices>(context);
    double height = MediaQuery.of(context).size.height * 0.6;
    double padding = MediaQuery.of(context).size.width * 0.1;
    final tamano = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 30),
      child: Container(
        decoration: cardBordes(),
        margin: EdgeInsets.only(top: 30),
        height: height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Inicio  jornada ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ChangeNotifierProvider(
                create: (_) => PhoneProvider(carnetservice.selectedProduct),
                child: Container(
                    height: tamano.height * 0.2,
                    width: tamano.width * 0.4,
                    child: Stack(
                      children: [
                        _BackgroundImage(jornadaServices.selectJornada.img),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                            iconSize: 35,
                            icon: const Icon(Icons.camera_alt_rounded),
                            onPressed: () async {
                              final picker = new ImagePicker();
                              final PickedFile? pickedFile =
                                  await picker.getImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 100);
                              if (pickedFile == null) {
                                return;
                              }
                              print('Tenemos imagen ${pickedFile.path}');
                              jornadaServices
                                  .updateSelectedJornadaImg(pickedFile.path);
                            },
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Row(
              children: [_AccessButton(), _EnableGpsMessage()],
            ),
            Row(
              children: [
                Text('Sede'),
                // MyStatefulWidget(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Boton(
                text: 'Registrar',
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, 'register');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration cardBordes() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 3), blurRadius: 10)
          ]);
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'one';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child:
          Container(width: double.infinity, height: 400, child: getImage(url)),
    );
  }

  Widget getImage(String? picture) {
    if (picture == null)
      return Image(image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);

    try {
      return Image.file(File(picture), fit: BoxFit.cover);
    } catch (e) {
      return const Image(
          image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
    }
  }
}
