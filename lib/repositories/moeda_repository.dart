import 'package:app_cripto/model/moedas.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
        icone: 'images/Bitcoin.png',
        nome: 'Bitcoin',
        sigla: 'BTC',
        preco: 201229.29),
    Moeda(
        icone: 'images/Cardano.png',
        nome: 'Cardano',
        sigla: 'ADA',
        preco: 4.13),
    Moeda(
        icone: 'images/Ethereum.png',
        nome: 'Ethereum',
        sigla: 'ETH',
        preco: 15499.52),
    Moeda(
        icone: 'images/Litecoin.png',
        nome: 'Litecoin',
        sigla: 'LTC',
        preco: 598.91),
    Moeda(
        icone: 'images/USD Coin.png',
        nome: 'USD Coin',
        sigla: 'USDC',
        preco: 5.12),
    Moeda(icone: 'images/XRP.png', nome: 'XRP', sigla: 'XRP', preco: 3.77),
  ];
}
