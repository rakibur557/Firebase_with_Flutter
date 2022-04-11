import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple/services/googleServiceProvider.dart';
import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String path = "HomeScreen";

  HomeScreen({Key? key, this.email, this.name, this.photoUrl})
      : super(key: key);

  final email, name, photoUrl;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  googleServiceProvider googleService = googleServiceProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elite APP'),
        centerTitle: true,
      ),
      body: Center(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.photoUrl),
          ),
          title: Text(widget.name),
          subtitle: Text(widget.email),
          trailing: ElevatedButton(
            onPressed: () async {
              googleService.logout();
              setState(() {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              });
            },
            child: Text('LogOut'),
          ),
        ),
      ),
    );
  }
}
