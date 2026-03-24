import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ProviderScope is required for Riverpod to work
  runApp(const ProviderScope(
    child: TheGameShopApp(),
  ));
}