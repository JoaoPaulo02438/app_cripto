import 'dart:collection';

import 'package:app_cripto/model/moedas.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../adapter/hive_adapter.dart';

class FavoritasRepository extends ChangeNotifier {
  List<Moeda> _lista = [];
  late LazyBox box;

  FavoritasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(MoedaHiveAdapter());
    box = await Hive.openLazyBox<Moeda>('moedas favoritas');
  }

  _readFavoritas() {
    box.keys.forEach((moeda) async {
      Moeda m = await box.get(moeda);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);
  //Método salvar moeda favorita usando hIVE
  saveAll(List<Moeda> moedas) {
    moedas.forEach((moeda) {
      if (!_lista.any((atual) => atual.sigla == moeda.sigla)) {
        _lista.add(moeda);
        box.put(moeda.sigla, moeda);
      }
      ;
    });
    notifyListeners();

    /* Método salvar moeda favorita usando shared preferences
  saveAll(List<Moeda> moedas) {
    moedas.forEach((moeda) {
      if (!_lista.contains(moeda)) _lista.add(moeda);
    });
    notifyListeners();
  }*/

    remove(Moeda moeda) {
      _lista.remove(moeda);
      box.delete(moeda);
      notifyListeners();
    }
  }
}
