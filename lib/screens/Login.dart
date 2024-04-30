import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _login = '';
  String _password = '';
  String _errorMessage = '';

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _login,
        password: _password,
      );
      // L'utilisateur est authentifié avec succès, naviguez vers '/demande' ou faites autre chose
      Navigator.pushNamed(context, '/demande');
    } catch (e) {
      // Une erreur s'est produite lors de l'authentification, afficher un message d'erreur
      setState(() {
        _errorMessage = 'Email ou mot de passe incorrect';
      });
    }
  }

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
                    _login = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    icon: Icon(Icons.lock),
                  ),
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
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      _loginUser();
                    }
                  },
                  child: Text('Envoyer'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/demande');
                  },
                  child: Text("Continuer en tant qu'invité"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subscribe');
                  },
                  child: Text('S\'inscrire'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
