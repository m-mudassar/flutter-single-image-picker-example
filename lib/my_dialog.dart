import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:single_image_picker/my_button.dart';

class MyDialog extends StatefulWidget {
  MyDialog(
      {Key? key,
      required this.onClickCamera,
      required this.onClickGallery,
      required this.onClickCancel})
      : super(key: key);

  final Function(int) onClickCamera;
  final Function(int) onClickGallery;
  final Function(int) onClickCancel;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: 200,
            child: SizedBox.expand(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                          textStyle: const TextStyle(
                              color: Color.fromRGBO(0, 122, 255, 1),
                              fontSize: 14),
                          title: 'Photo Gallery',
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          onTap: () {
                            widget.onClickGallery(1);
                          }),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                          title: 'Camera',
                          textStyle: const TextStyle(
                              color: Color.fromRGBO(0, 122, 255, 1),
                              fontSize: 14),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          onTap: () {
                            widget.onClickCamera(2);
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                          title: 'Cancel',
                          textStyle: const TextStyle(
                              color: Color.fromRGBO(0, 122, 255, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          onTap: () {
                            widget.onClickCancel(3);
                          }),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
