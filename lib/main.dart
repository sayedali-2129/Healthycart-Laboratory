import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/app.dart';
import 'package:healthy_cart_laboratory/core/di/injection.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependancy();
  runApp(const App());
}
