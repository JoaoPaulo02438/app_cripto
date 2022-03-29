import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  //Utilização do shared preferences{
  //Comentar a linha declarativa do shared preferences(late SharedPreferences _prefs;)
  //Comentar a linha declarativa do shared preferences na função start
  //Alterar método readLocale e setLocale
  //late SharedPreferences _prefs;
  //_prefs = await SharedPreferences.getInstance();}

  //late SharedPreferences _prefs;
  //Utilização do Hive.'Hive trabalha com Box e não database'.
  //Declaração do Hive
  late Box box;
  Map<String, String> locale = {'locale': 'pt_BR', 'name': 'R\$'};
  AppSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    //_prefs = await SharedPreferences.getInstance();
    box = await Hive.openBox('preferencias');
  }

  _readLocale() {
    final local = box.get('local') ?? 'pt_BR';
    final name = box.get('name') ?? 'pt_BR';
    //final local = _prefs.getString('local') ?? 'pt_BR';
    //final name = _prefs.getString('name') ?? 'pt_BR';
    locale = {
      'locale': local,
      'name': name,
    };
    notifyListeners();
  }

  setLocale(String local, String name) async {
    await box.put('local', local);
    await box.put('name', name);
    //await _prefs.setString('local', local);
    //await _prefs.setString('name', name);
    await _readLocale();
  }
}
