import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/env.dart';
import '../../../recommendation/presentation/utils/functions.dart';

class ContactInformation extends StatelessWidget{
  final BoxConstraints screenSize;
  final dynamic user;
  ContactInformation({required this.screenSize, required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
            color: Color.fromARGB(255, 187, 148, 48),
            width: screenSize.maxWidth,
            height: screenSize.maxHeight * 0.15,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.maxHeight * 0.08,width: screenSize.maxWidth*0.15,),
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white, width: 1),
                      image: DecorationImage(
                        image: NetworkImage("http://${ipAdress}:8000/${user.image.split("\\").last}"),
                        // FileImage(File(user.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
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