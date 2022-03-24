import 'package:app_cripto/model/moedas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoedasDetalhesPage extends StatefulWidget {
  Moeda moeda;
  MoedasDetalhesPage({Key? key, required this.moeda}) : super(key: key);

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  comprar() {
    if (_form.currentState!.validate()) {
      //salvar no banco de dados

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Compra realizada com sucesso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.moeda.nome),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(widget.moeda.icone),
                      width: 50,
                    ),
                    Container(width: 10),
                    Text(
                      real.format(widget.moeda.preco),
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1,
                          color: Colors.blueGrey[800]),
                    )
                  ],
                ),
              ),
              //Calculadora para mostrar o valor em cripto moedas
              (quantidade > 0)
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: Text(
                          '$quantidade ${widget.moeda.sigla}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 24),
                        alignment: Alignment.center,
                      ))
                  : Container(
                      margin: EdgeInsets.only(bottom: 24),
                    ),
              //Formularo
              Form(
                key: _form,
                child: TextFormField(
                  controller: _valor,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      //labelText: "R\$",
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      suffix: Text(
                        'reais',
                        style: TextStyle(fontSize: 14),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o valor da compra';
                    } else if (double.parse(value) < 50) {
                      return 'Compra minima é R\$ 50,00';
                    }
                    return null;
                  },
                  //Reatividade{conversão do valor digitado em reais para cripto moeda}
                  onChanged: (value) {
                    setState(() {
                      quantidade = (value.isEmpty)
                          ? 0
                          : double.parse(value) / widget.moeda.preco;
                    });
                  },
                ),
              ),
              //Inserir botão comprar
              Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //Incluir icone check no botão
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(Icons.check),
                          //Incluir String dentro do botão
                          // ignore: prefer_const_constructors
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Comprar',
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      onPressed: comprar))
            ])));
  }
}
