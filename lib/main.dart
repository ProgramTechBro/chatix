import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app.dart';
import 'core/di/injector.dart';

void main() {
  configureDependencies();
  runApp(const ProviderScope(child: ChatixApp()));
}
