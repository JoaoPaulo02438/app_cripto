import 'dart:math';
import 'package:app_cripto/pages/moedas_detalhes_page.dart';
import 'package:app_cripto/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/moedas.dart';

class MoedasPage extends StatefulWidget {
  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  Color color = Colors.indigo;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        backgroundColor: color,
        title: Text('Cripto Moedas'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => setState(() {
                    color = Colors.indigo;
                  }),
              icon: Icon(Icons.color_lens))
        ],
      );
    } else {
      return AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                selecionadas = [];
              });
            },
          ),
          title: Text('${selecionadas.length} selecionadas'),
          backgroundColor: Colors.blueGrey[200],
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold));
    }
  }

  //Função para acessar os detalhes da moeda selecionada.
  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MoedasDetalhesPage(moeda: moeda),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDinamica(),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              leading: (selecionadas.contains(tabela[moeda]))
                  ? CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      child: Image.asset(tabela[moeda].icone),
                      //width: 40,
                    ),
              title: Text(
                tabela[moeda].nome,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                real.format(tabela[moeda].preco),
              ),
              selected: selecionadas.contains(tabela[moeda]),
              onLongPress: () {
                setState(() {
                  (selecionadas.contains(tabela[moeda]))
                      ? selecionadas.remove(tabela[moeda])
                      : selecionadas.add(tabela[moeda]);
                });
              },
              //Navegar em telas
              onTap: () => mostrarDetalhes(tabela[moeda]),
            );
          },
          itemCount: tabela.length,
          padding: EdgeInsets.all(8),
          separatorBuilder: (_, __) => Divider(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selecionadas.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () {},
                icon: Icon(Icons.star),
                label: Text(
                  'FAVORITOS',
                  style:
                      TextStyle(letterSpacing: 0, fontWeight: FontWeight.bold),
                ))
            : null);
  }
}
