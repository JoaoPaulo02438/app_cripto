import 'package:app_cripto/configs/app_settings.dart';
import 'package:app_cripto/myapp.dart';
import 'package:app_cripto/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/hive_configs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository())
      ],
      child: MyApp(),
    ),
  );
}
