import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:mysql1/mysql1.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _nom = '';
  String _ville = '';
  String _numero = '';
  String _adresse = '';
  String _password = '';
  String _confirm_password = '';

  @override
  Widget build(BuildContext context) {
    // Future<void> _submitForm() async {
    //   var settings = new ConnectionSettings(
    //       host: 'localhost',
    //       port: 3306,
    //       user: 'root',
    //       password: 'root',
    //       db: 'iconnect');
    //   var conn = await MySqlConnection.connect(settings);
    //   await conn.query(
    //       "INSERT INTO iconnect_inscription (id,nom, email, mot_de_passe, confirmer_mot, numero_tel,adresse, ville) VALUES (?,?, ?, ?, ?, ?, ?, ?)");
    //   await conn.close();
    // }

    Future<void> _submitForm() async {
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
      await conn.query(
          "INSERT INTO iconnect_inscription (id,nom, email, mot_de_passe, confirmer_mot, numero_tel,adresse, ville) VALUES (?,?,?,?,?,?,?,?)",
          [
            null,
            _nom,
            _email,
            _password,
            _confirm_password,
            _numero,
            _adresse,
            _ville
          ]);
      await conn.close();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Succès'),
            content: Text('L\'insertion a réussi.'),
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
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un Compte'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_add,
                  size: 100.0,
                  color: Colors.blue,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom & Prenom',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nom & Prenom Obligatoire';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nom = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                    prefixIcon: Icon(Icons.lock),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmer le Mot de Passe',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'La confirmation est Obligatoire';
                    }
                    if (_confirm_password != _password) {
                      return 'Les valeurs sont érronées';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _confirm_password = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Numero de Telephone',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Le numero est  Obligatoire';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _numero = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Adresse d\' habitat',
                    prefixIcon: Icon(Icons.location_city_rounded),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Adresse   Obligatoire';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _adresse = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ville',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'La ville est  Obligatoire';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _ville = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Créer un Compte'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
