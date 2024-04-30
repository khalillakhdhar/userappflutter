import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EcranEnvoiDemande extends StatefulWidget {
  @override
  _EcranEnvoiDemandeState createState() => _EcranEnvoiDemandeState();
}

class _EcranEnvoiDemandeState extends State<EcranEnvoiDemande> {
  final _formKey = GlobalKey<FormState>();
  String _demandeur = '';
  String _depart = '';
  String _description = '';
  String _destination = '';
  String _etat = 'attente';
  String _type = 'Véhicule B';
  DateTime _date = DateTime.now();

  bool _positionCharged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envoi de demande depuis votre position'),
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
                    labelText: 'Départ',
                    icon: Icon(Icons.location_on),
                  ),
                  controller: TextEditingController(text: _depart),
                  readOnly:
                      true, // Le champ est en lecture seule pour afficher la position par défaut
                  onTap: () {
                    _fetchUserPosition();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    icon: Icon(Icons.description),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer la description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                TextFormField(
                  initialValue: _destination,
                  decoration: InputDecoration(
                    labelText: 'Destination',
                    icon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer la destination';
                    }
                    return null;
                  },
                  readOnly:
                      true, // Le champ est en lecture seule pour afficher la position par défaut
                  onSaved: (value) {
                    _destination = value!;
                  },
                ),
                TextFormField(
                  initialValue: _etat,
                  decoration: InputDecoration(
                    labelText: 'État',
                    icon: Icon(Icons.check_circle),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer l\'état';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _etat = value!;
                  },
                ),
                TextFormField(
                  initialValue: _type,
                  decoration: InputDecoration(
                    labelText: 'Type',
                    icon: Icon(Icons.directions_car),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer le type';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _type = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _envoyerDonnees,
                  child: Text('Envoyer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fetchUserPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _depart = '${position.latitude}, ${position.longitude}';
        _positionCharged = true;
        print("Position chargée: $_depart");
      });
    } catch (e) {
      print('Error fetching position: $e');
      // Handle error (e.g., show a snackbar or dialog)
    }
  }

  void _envoyerDonnees() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Récupérer l'utilisateur actuellement authentifié
      User? user = FirebaseAuth.instance.currentUser;

      // Création d'un objet pour Firestore
      var demandeData = {
        'demandeur': user?.uid ?? 'Utilisateur non authentifié',
        'depart': _depart,
        'description': _description,
        'destination': _destination,
        'etat': _etat,
        'type': _type,
        'date': _date.toIso8601String(),
      };

      // Envoi à Firestore
      try {
        await FirebaseFirestore.instance
            .collection('demandes')
            .add(demandeData);
        print('Données envoyées avec succès!');
        Navigator.pushNamed(
            context, '/maPosition'); // ou n'importe quelle navigation
      } catch (e) {
        print("Erreur lors de l'envoi à Firestore: $e");
      }
    }
  }
}
