import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Subscribe extends StatefulWidget {
  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  final _formKey = GlobalKey<FormState>();
  String _nom = '';
  String _prenom = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification'),
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
                    labelText: 'Nom',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer le nom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nom = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer le prénom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _prenom = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Email ou nom d'utilisateur";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer le mot de passe';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: _email,
                          password: _password,
                        );

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userCredential.user!.uid)
                            .set({
                          'nom': _nom,
                          'prenom': _prenom,
                          'email': _email,
                        });

                        // Utilisateur inscrit avec succès, redirigez-le vers une autre page
                        Navigator.pushNamed(context,
                            '/'); // Redirigez vers la page de connexion par exemple
                      } catch (e) {
                        // Gestion des erreurs lors de l'inscription de l'utilisateur
                        print('Erreur lors de l\'inscription : $e');
                        // Affichez un message d'erreur à l'utilisateur si nécessaire
                      }
                    }
                  },
                  child: Text('Envoyer'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text("Déjà inscrit? Connectez-vous ici"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
