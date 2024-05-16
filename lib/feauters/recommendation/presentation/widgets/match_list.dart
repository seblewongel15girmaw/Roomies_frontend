import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/functions.dart';



class MatchList extends StatelessWidget {
  final roommates;
  final userId;
  MatchList(this.roommates,this.userId);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: roommates.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 17,right: 17),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/matchprofile',arguments:{"roommates":roommates[index].user, "userId":userId});
              },
              child: Card(
                color:  Color.fromARGB(255, 255, 255, 221),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              40), // Half of the height/width to make it circular
                          border: Border.all(
                              color: Colors.black, width: 1), // Border properties
                          image: DecorationImage(
                            image: FileImage(File(roommates[index].user.image)),
                            fit: BoxFit
                                .cover, // Stretch and fit the image within the container
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              capitalize(roommates[index].user.userName),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              roommates[index].user.jobStatus,
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
