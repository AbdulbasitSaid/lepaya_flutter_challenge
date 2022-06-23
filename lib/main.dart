import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_assignment/app_bloc_observer.dart';
import 'package:flutter_assignment/application_layer/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/get_it.dart' as get_it;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(get_it.init());

  BlocOverrides.runZoned(() => runApp(App()), blocObserver: AppBlocObserver());
}
