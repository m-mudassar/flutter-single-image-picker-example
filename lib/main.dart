import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_image_picker/my_button.dart';
import 'package:single_image_picker/my_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        // primarySwatch:Color.fromRGBO(229, 229, 229, 1.0),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SingleImagePicker(title: 'Single Image Picker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SingleImagePicker extends StatefulWidget {
  const SingleImagePicker({super.key, required this.title});

  final String title;

  @override
  State<SingleImagePicker> createState() => _SingleImagePickerState();
}

class _SingleImagePickerState extends State<SingleImagePicker> {
  ImagePicker picker = ImagePicker();
  // ImageData imageData = ImageData();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 68, 148, 1),
        title: Center(
            child: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ImageContainer(
                imageFile: _image,
              ),
              const SizedBox(
                height: 16,
              ),
              flatButton('Upload Image', () {
                showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.3),
                  transitionDuration: Duration(milliseconds: 500),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return MyDialog(onClickGallery: (action) {
                      if (action == 1) {
                        pickImageFromGallery();
                        Navigator.pop(context);
                      }
                    }, onClickCamera: (action) {
                      if (action == 2) {
                        takeImageFromCamera();
                        Navigator.pop(context);
                      }
                    }, onClickCancel: (action) {
                      if (action == 3) {
                        Navigator.pop(context);
                      }
                    });
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     height: 300,
                    //     child: SizedBox.expand(child: FlutterLogo()),
                    //     margin:
                    //         EdgeInsets.only(bottom: 50, left: 12, right: 12),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(40),
                    //     ),
                    //   ),
                    // );
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      transformHitTests: true,
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                          .animate(anim1),
                      child: child,
                    );
                  },
                );
              })
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget flatButton(String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 116, vertical: 20),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 68, 148, 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) widget.imageUrl = null;
    initImageData(pickedFile);
  }

  Future takeImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    // if (pickedFile != null) widget.imageUrl = null;
    initImageData(pickedFile);
  }

  void initImageData(XFile? pickedFile) {
    try {
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}

class ImageContainer extends StatelessWidget {
  ImageContainer({super.key, this.imageFile});
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 241, 241, 1),
        border:
            Border.all(color: const Color.fromRGBO(189, 189, 189, 1), width: 2),
      ),
      height: 330,
      width: 343,
      child: imageFile != null
          ? Image.file(
              imageFile!,
              fit: BoxFit.fill,
            )
          : const SizedBox(),
    ); // Image.file(file));
  }
}
