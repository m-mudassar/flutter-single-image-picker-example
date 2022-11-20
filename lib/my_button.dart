import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String title;
  Function()? onTap;
  EdgeInsets? padding;
  Decoration? decoration;
  TextStyle? textStyle;
  MyButton(
      {Key? key,
      required this.title,
      this.onTap,
      this.padding,
      this.decoration,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap ?? () {},
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(0),
        child: Container(
          constraints: BoxConstraints(minWidth: 80),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: decoration,
          child: SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
