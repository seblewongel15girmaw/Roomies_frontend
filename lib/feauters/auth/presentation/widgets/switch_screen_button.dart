import 'package:flutter/material.dart';

class SwitchScreen extends StatelessWidget {
  final String pageRoute;
  final String buttonName;
  final String direction;
  const SwitchScreen(
      {super.key,
      required this.pageRoute,
      required this.buttonName,
      required this.direction});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, pageRoute);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: direction == "right"
                ? BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25))
                : BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
            color:  Color.fromARGB(255, 187, 148, 48)),
        height: 40,
        width: 120,
        child: Center(
            child: Text(
          buttonName,
          style: TextStyle(fontSize: 20, color: Colors.white),
        )),
      ),
    );
  }
}
