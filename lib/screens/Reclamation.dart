// ignore_for_file: unused_field, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Reclamation extends StatefulWidget {
  @override
  _ReclamationState createState() => _ReclamationState();
}

class _ReclamationState extends State<Reclamation> {
  final _formKey = GlobalKey<FormState>();
  String _emetteur = '';
  String _objet = '';
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envoi de Reclamation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Emmetteur',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Veuillez entrer l'emmetteur";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emetteur = value!;
                  },
                ),
                // textarea feild _objet
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Objet',
                    icon: Icon(Icons.check_box),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer l\'objet';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _objet = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      // Envoyer la demande
                    }
                  },
                  child: Text('Envoyer'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  // change button color

                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text("Retour à l\'accueil"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
