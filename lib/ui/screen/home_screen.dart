import 'package:flutter/material.dart';

import 'package:gobernacion/services/services.dart';
import 'package:gobernacion/ui/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/models.dart';

// import 'package:gob_cordoba/ui/widgets/widgets.dart';
// import 'package:gob_cordoba/ui/screen/screens.dart';
// import 'package:gob_cordoba/provider/provider.dart';
// import 'package:gob_cordoba/models/models.dart';
// import 'package:gob_cordoba/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size.height * 0.09;
    final carnetservice = Provider.of<CarnetService>(context);
    final dato = carnetservice.loadCartUser();
    final prefe = UserPrefe();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            actions: [
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () async {
                        Usuario local = Usuario();
                        local = await prefe.getUserInfo();
                        _scaffoldKey.currentState?.openDrawer();
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
            // leading: IconButton(
            //     icon: const Icon(Icons.menu, color: Colors.black),
            //     onPressed: () {}
            //     // onPressed: () async {
            //     //   final picker = new ImagePicker();
            //     //   final PickedFile? pickedFile = await picker.getImage(
            //     //       source: ImageSource.gallery, imageQuality: 100);
            //     //   if (pickedFile == null) {
            //     //     print('No selecciono nada');
            //     //     return;
            //     //   }
            //     //   displayDialog(context, pickedFile.path);
            //     //   //  ShowImg(model: pickedFile.path);
            //     //   print('Tenemos imagen ${pickedFile.path}');
            //     //   //  carnetservice.uploadImage(pickedFile.path);
            //     // },
            //     ),
            backgroundColor: Colors.white,
            elevation: 1),
        body: FutureBuilder<Usuario>(
            future: carnetservice.loadCartUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CardWidget(dato: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black12),
                );
              }
            }),
        drawer: DrawerWidget()
        // bottomNavigationBar: const CustomNavigatonBar (),
        );
  }
}
