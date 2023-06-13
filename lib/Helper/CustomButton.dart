import 'package:flutter/material.dart';

import '../Helper/Color.dart';
class Btn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Btn({Key? key,
    this.title, this.onPress, this.height, this.width, this.fSize, this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.primary,
                  colors.primary,

                ],
                stops: [
                  0,
                  1,
                ]),
             borderRadius: BorderRadius.circular(10),
            // border: Border.all(color:colors.primary)
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            "$title",
            style:  TextStyle(
              color: colors.primary,
              fontSize: fSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
