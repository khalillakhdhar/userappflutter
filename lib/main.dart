import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:userapp/screens/EcranCarte.dart';
import 'package:userapp/screens/EcranEnvoiDemande.dart';
import 'package:userapp/screens/Login.dart';
import 'package:userapp/screens/Reclamation.dart';
import 'package:userapp/screens/Subscribe.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demande de dépannage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/demande': (context) => EcranEnvoiDemande(),
        '/maPosition': (context) => MinimumExample(),
        "/envoiReclamation": (context) => Reclamation(),
        "/subscribe": (context) => Subscribe()
      },
    );
  }
}
