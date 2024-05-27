import 'dart:io';
import 'package:begara_mobile/core/util/locations.dart';
import 'package:flutter/material.dart';

import '../utils/functions.dart';

class UserProfilePage extends StatelessWidget {
  final user;
  final userId;
  UserProfilePage({required this.user,required this.userId});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent, // Make the app bar transparent
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenSize.height * 0.45,
              child: Stack(children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.6,
                      image: FileImage(File(user.image)),
                      fit: BoxFit
                          .cover, // Stretch and fit the image within the container
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.28,
                        ),
                        Text(
                          capitalize(user.userName),
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          capitalize(user.jobStatus),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: -10,
                    right: 10,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/chats",arguments: {"user":user, "userId":userId} );
                        },
                        icon: Icon(
                          Icons.message_sharp,
                          color: Colors.amber,
                          size: 70,
                        )))
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Lives Around",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(places[user.address.toString()] ?? "Unknown",
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    user.bio,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
