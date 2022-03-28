import 'package:app_cripto/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/moeda_card.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({Key? key}) : super(key: key);

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moedas Favoritas'),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.indigo.withOpacity(0.05),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12.0),
          child: Consumer<FavoritasRepository>(
            builder: (context, favoritas, child) {
              return favoritas.lista.isEmpty
                  ? ListTile(
                      title: Text('Ainda não há moedas favorita!'),
                      leading: Icon(
                        Icons.star,
                        color: Colors.indigo,
                      ))
                  : ListView.builder(
                      itemCount: favoritas.lista.length,
                      itemBuilder: (_, index) {
                        return MoedaCard(moeda: favoritas.lista[index]);
                      },
                    );
            },
          )),
    );
  }
}
