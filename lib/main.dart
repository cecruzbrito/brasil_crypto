import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app_module.dart';
import 'main_widget.dart';

Future<void> main() async {
  runApp(ModularApp(module: AppModule(), child: MainWidget()));
}
