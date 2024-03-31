import 'package:flutter/material.dart';
import 'package:note_app/app_config.dart';
import 'package:note_app/notes_app/data/di/notes_di.dart';
import 'package:note_app/notes_app/presentation/pages/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies(appEnvironment: AppEnvironment.sqfLite);

  AppConfig configureApp =  AppConfig(
    environment: AppEnvironment.sqfLite,
    appTitle: 'sqlLite',
    child: MyApp(
      title: AppEnvironment.sqfLite.name,
    ),
  );

  runApp(configureApp);
}
