import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  googleServiceProvider googleService = googleServiceProvider();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(),
      mainScreen: Home(),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      menuBackgroundColor: Colors.deepPurple,
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
      ),
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
      backgroundColor: Colors.deepPurple,
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
                      radius: 53,
                      backgroundColor: Colors.blue,
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
                      child:
                          Icon(Icons.add_a_photo, color: Colors.deepPurple),
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
                color: Colors.white,
              ),
            ),
            Text(
              'rahmanrakib780@gmail.com'.toLowerCase(),
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.white, thickness: 0.5,indent: 1),
            ),
            SizedBox(height: 5,),
            drawerList(Icons.settings_system_daydream_sharp, 'Dashboard'),
            SizedBox(height: 20,),
            drawerList(Icons.people, 'People'),
            SizedBox(height: 20,),
            drawerList(Icons.favorite, 'Favourite'),
            SizedBox(height: 20,),
            drawerList(Icons.settings, 'Settings'),
            SizedBox(height: 20,),
            drawerList(Icons.code, 'Developer'),
            SizedBox(height: 20,),
            drawerList(Icons.star, 'Rating Us'),
            SizedBox(height: 20,),
            drawerList(Icons.help, 'Help'),
            SizedBox(height: 20,),
            drawerList(Icons.info, 'About'),
            SizedBox(height: 20,),
            drawerList(Icons.logout, 'Logout'),
          ],
        ),
      ),
    );
  }

  Widget drawerList(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Icon(icon,color: Colors.white),
          SizedBox(
            width: 10,
          ),
          Text(text, style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),),
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

/*
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  googleServiceProvider googleService = googleServiceProvider();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elite APP'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Center(
          child: Column(
        children: [
          //SizedBox(height: 10,),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 63,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        image == null ? null : FileImage(image!),
                  ),
                ),
              ),
              Positioned(
                  top: 115,
                  left: 105,
                  child: RawMaterialButton(
                    elevation: 10,
                    fillColor: Colors.blue,
                    child: Icon(Icons.add_a_photo, color: Colors.white),
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
                                            padding: const EdgeInsets.all(8.0),
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
                                            padding: const EdgeInsets.all(8.0),
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

          ListTile(
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
        ],
      )),
    );
  }

  final ImagePicker _picker = ImagePicker();
  File? image;
  Future pickImg()async{
    try{
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch(e){
      print('Failed to pick image: ${e}');
    }
  }

  Future pickCamera()async{
    try{
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch(e){
      print('Failed to pick image: ${e}');
    }
  }
}
*/
