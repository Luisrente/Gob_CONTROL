import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gobernacion/models/loginResponse.dart';
import 'package:gobernacion/models/models.dart';
import 'package:gobernacion/services/services.dart';
import 'package:http/http.dart' as http;

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  // final storage = new FlutterSecureStorage();
  List<Usuario> usuarios = [];
  late Usuario usuario;

  final prefe = UserPrefe();

  bool _autenticando = false;

  // final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final data = {'correo': email, 'password': password};
    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/auth/login');

      final resp = await http.post(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;
        await prefe.setUserInfo(usuario);
        return true;
      } else {
        // final respBody = jsonDecode(resp.body);
        // NotificationsService.showSnackbar(respBody['msg']);
        return false;
      }
    } catch (e) {
      return false;
      // NotificationsService.showSnackbar("Comunicarse con el admin ");
    }
  }

  Future<String> password(String password) async {
    final data = {'password': password};
    final Usuario user = await prefe.getUserInfo();

    try {
      final uri =
          Uri.parse('https://apigob.herokuapp.com/api/usuarios/${user.id}');
      final resp = await http.put(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      print('paso');
      if (resp.statusCode == 200) {
        print('entro');
        return '1';
        // await this._guardarToken(loginResponse.token);
      } else {
        final respBody = jsonDecode(resp.body);
        NotificationsService.showSnackbar(respBody['msg']);
        return '';
      }
    } catch (e) {
      NotificationsService.showSnackbar("Comunicarse con el admin ");
    }
    return '';
  }

  Future<String> colorTheme(String id) async {
    final data = {'color': id};

    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/color');
      final resp = await http.post(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      print('paso');
      if (resp.statusCode == 200) {
        print('entro');
        return '1';
        // await this._guardarToken(loginResponse.token);
      } else {
        final respBody = jsonDecode(resp.body);
        NotificationsService.showSnackbar(respBody['msg']);
        return '';
      }
    } catch (e) {
      NotificationsService.showSnackbar("Error color ");
    }
    return '';
  }

  datosbase() async {
    // isLoading = true;
    notifyListeners();
    Usuario dato2 = Usuario();
    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/usuarios');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200) {
        print(resp);
        print('paso por el metodo base(dfdfdfdfd)');
        final loginResponse = getsUsuarioFromJson(resp.body);
        usuarios = loginResponse.usuario;
        print(usuarios[0]);
        for (var i = 0; i < usuarios.length - 1; i++) {
          // final s =  await DBProvider.db.nuevoScan(usuarios[i]);
        }
        // final s =  await DBProvider.db.getTodosLosScans();
        // print(s.length);
      }
    } catch (e) {
      // NotificationsService.showSnackbar("Comunicarse con admin base local ");
    }
  }

  // Future logunt() async {
  //   await storage.delete(key: 'token');
  //   await storage.delete(key: 'id');
  //   // await DBProvider.db.deleteAllScan();
  //   return;
  // }

  // Future<String> readToken() async {
  //   return await storage.read(key: 'token') ?? '';
  // }

  // Future<String> readId() async {
  //   return await storage.read(key: 'id') ?? '';
  // }

  // Future<String> readData() async {
  //   return await storage.read(key: 'email') ?? '';
  // }

}
