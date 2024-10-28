
import 'package:flutter/material.dart';

import '../constantes/constantes.dart';

class SchoolChoiceWidget extends StatelessWidget {
  const SchoolChoiceWidget({
    super.key,
    required this.widthBtn,
    required this.heightBtn,
    required this.btnColor,
    this.onPressed,
    required this.btnTitle,
    this.btnleftIcon,
    this.btnRightIcon, 
    required this.imageUrl,

  });

  final double widthBtn;
  final double heightBtn;
  final Color? btnColor;
  final Function()? onPressed;
  final String btnTitle;
  final String imageUrl;
  final IconData? btnleftIcon;
  final IconData? btnRightIcon;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * widthBtn,
      height: height * heightBtn,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          elevation: 10,
          side: const BorderSide(
            width: 3,
            color: Color.fromARGB(255, 89, 89, 91),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.0,
              child: Image(
                image: AssetImage("assets/images/$imageUrl.png"),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            Center(
              child: Text(
                btnTitle,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Icon(
              btnRightIcon,
              color: Colors.white,
              size: 55,
              weight: 80,
            ),
          ],
        ),
      ),
    );
  }
}
