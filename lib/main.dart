import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:place_finder/view_models/place_list_view_model.dart';
import 'package:place_finder/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ChangeNotifierProvider(
          create: (context) => PlaceListViewModel(),
          child: const HomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}
