import 'package:flutter/material.dart';
import 'createaccount.dart';
import 'Accueil.dart';
import 'package:mysql1/mysql1.dart';
import 'HomePage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _conf_email = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
      );
      // Do something with the form data, e.g. authenticate user
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _SubmitForm() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      var settings = new ConnectionSettings(
          host: '192.168.1.77',
          port: 3306,
          user: 'francky',
          password: 'root',
          db: 'iconnect');
      var conn = await MySqlConnection.connect(settings);

      var results = await conn.query(
          'select * from iconnect_inscription where email = ? and mot_de_passe = ?',
          [_email, _password]);

      if (results.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Succès'),
              content: Text('Connexion réussie.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('echec'),
              content: Text(
                'Connexion non  réussie.',
                style: TextStyle(color: Colors.red),
              ),
              // actions: <Widget>[
              // TextButton(
              //   child: Text('OK'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => MyHomePage()));
              //   },
              // ),
              //],
            );
          },
        );
      }
      await conn.close();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Colors.blue[700],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email Obligatoire';
                    } else if (!value.contains('@')) {
                      return 'Votre email est invalide!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de Passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mot de Passe Obligatoire';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _SubmitForm,
                  child: Text('Login'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Verification par Email'),
                          content: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email Obligatoire';
                              } else if (!value.contains('@')) {
                                return 'Votre email est invalide!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _conf_email = value!;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Envoyer'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Annuler'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Mot de passe oublié ?'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                    );
                  },
                  child: Text('Vous n\'avez pas de Compte? Creez-en un'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
