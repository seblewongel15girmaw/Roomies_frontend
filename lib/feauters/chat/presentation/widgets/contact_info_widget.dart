import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../recommendation/presentation/utils/functions.dart';

class ContactInformation extends StatelessWidget{
  final Size screenSize;
  final dynamic user;
  ContactInformation({required this.screenSize, required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
            color: Color.fromARGB(255, 187, 148, 48),
            width: screenSize.width,
            height: screenSize.height * 0.15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white, width: 1),
                      image: DecorationImage(
                        image: FileImage(File(user.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    capitalize(user.userName),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
  }

}