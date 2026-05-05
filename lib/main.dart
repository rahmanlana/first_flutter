import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wri_fluter/pages/homepage.dart';
import 'package:wri_fluter/provider/trxProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: Homepage(),
      ),
    );
  }
}
