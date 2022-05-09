import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple/services/googleServiceProvider.dart';
import 'LoginScreen.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String path = "HomeScreen";

  HomeScreen({Key? key, this.email, this.name, this.photoUrl})
      : super(key: key);

  final email, name, photoUrl;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(),
      mainScreen: Home(),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      menuBackgroundColor: Color(0xff2c3e50),
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Flutter Elite App'),
        centerTitle: true,
        leading: DrawerWidget(),
        actions: [
          IconButton(
            onPressed: () async {
              await Share.share('Check out this application. \n\nPlaystore: https://www.youtube.com/watch?v=CNUBhb_cM6E', subject: 'Look what I made!');
            },
            icon: Icon(Icons.share),
          ),
          SizedBox(width: 10,),
        ],
      ),
      //body: , //*****************************
    );
  }
}

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2c3e50),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xff34495e),
                      backgroundImage: image == null ? null : FileImage(image!),
                    ),
                  ),
                ),
                Positioned(
                    top: 100,
                    left: 90,
                    child: RawMaterialButton(
                      elevation: 10,
                      fillColor: Colors.white,
                      child: Icon(Icons.add_a_photo, color: Colors.black),
                      shape: CircleBorder(),
                      onPressed: () {
                        showDialog(
                            //  useRootNavigator: Navigator.canPop(context),
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Choose an option',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blue),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.blue,
                                        onTap: () {
                                          pickCamera();
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.camera_alt),
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.blue,
                                        onTap: () {
                                          pickImg();
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.image),
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        // setState(() {
                        //   Navigator.pop(context);
                        // });
                      },
                    )),
              ],
            ),
            Text(
              'RAKIBUR RAHMAN'.toUpperCase(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff1abc9c),
              ),
            ),
            Text(
              'rahmanrakib780@gmail.com'.toLowerCase(),
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.white, thickness: 0.5, indent: 1),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.settings_system_daydream_sharp,
                    'Dashboard', '0xffe9c46a')),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.people, 'People', '0xff3498db')),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.favorite, 'Favourite', '0xffe74c3c')),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.settings, 'Settings', '0xff00c49a')),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.code, 'Developer', '0xffffffff')),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.star, 'Rating Us', '0xff4cc9f0')),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.help, 'Help', '0xffc77dff')),
            InkWell(
                onTap: () {},
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.info, 'About', '0xffffe066')),
            InkWell(
                onTap: () async {
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
                splashColor: Colors.blueAccent,
                child: drawerList(Icons.logout, 'Logout', '0xffED4C67')),
          ],
        ),
      ),
    );
  }

  googleServiceProvider googleService = googleServiceProvider();

  Widget drawerList(IconData icon, String text, String colorCode) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Icon(icon, color: Color(int.parse(colorCode))),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

//image picker
  final ImagePicker _picker = ImagePicker();
  File? image;

  Future pickImg() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e}');
    }
  }

  Future pickCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e}');
    }
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ZoomDrawer.of(context)!.toggle();
      },
      icon: Icon(Icons.menu),
    );
  }
}
