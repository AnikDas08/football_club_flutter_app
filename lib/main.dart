import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/core/global_error_handler.dart';
import 'config/dependency/dependency_injection.dart';
import 'main.dart' as LocalStorage;
import 'myapp.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (d) => globalError(d.exception, d.stack);
    runApp(const MyApp());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }, (error, stack) => globalError(error, stack));
}

Future<void> init() async {
  try {
    final dI = DependencyInjection();
    dI.dependencies();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    await Future.wait([
      SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]),
      LocalStorage.init(),
    ]);

    /*Future.delayed(const Duration(milliseconds: 300), () {
      SocketService.connect();
    });*/
  } catch (e, stack) {
    globalError(e, stack);
  }
}


