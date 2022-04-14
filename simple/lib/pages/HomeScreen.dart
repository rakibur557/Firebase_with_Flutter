import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elite APP'),
        centerTitle: true,
      ),
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
                    radius: 65,
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

  // final ImagePicker _picker = ImagePicker();
  //File? image;
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
