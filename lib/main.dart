import 'package:drawing_app/di/get_it.dart';
import 'package:drawing_app/presentation/index.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const Index());
}
