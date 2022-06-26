import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gobernacion/models/models.dart';

class JornadaServices extends ChangeNotifier {
  Jornada selectJornada = Jornada();
  File? newPictureFile;

  // Usuario local = Usuario();

  JornadaServices() {}

  void updateSelectedJornadaImg(String path) {
    selectJornada.img = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}
