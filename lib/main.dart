import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Iconnectvousdepanne',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Couleur principale de l'application
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IconnectHome(),
    );
  }
}

class IconnectHome extends StatefulWidget {
  const IconnectHome({Key? key}) : super(key: key);

  @override
  State<IconnectHome> createState() => _IconnectHomeState();
}

class _IconnectHomeState extends State<IconnectHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iconnectvousdepanne')
      ),
      body: Center(
        //child: Text('Bienvenue sur Iconnectvousdepanne',style: TextStyle(fontSize: 28)),
        child:
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              Text('Bienvenue',style: TextStyle(fontSize: 28, color: Colors.blue)),

              Text('Iconnectvousdepanne',style: TextStyle(fontSize: 35, color: Colors.orange))
            ],
          )
      ),
    );
  }
}
