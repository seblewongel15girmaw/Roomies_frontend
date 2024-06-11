import 'dart:io';

import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

import '../../../../core/util/env.dart';
import '../blocs/contacts/contacts.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
        if (state is Idle) {
          BlocProvider.of<ContactsBloc>(context).add(ContactsEvent());
        }
        return state is LoadingContactsSuceess
            ? ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/chats", arguments: {
                        "user": state.contacts[index].user,
                        "userId": state.userId
                      });
                    },
                    child: Container(
                        width: screenSize.width,
                        height: 100,
                        child: Card(
                          color: Color.fromARGB(255, 243, 235, 212),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.zero, // Set border radius to zero
                            side: BorderSide.none, // Set border side to none
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Align items vertically in the center
                              children: [
                                Container(
                                  
                                  height: 63,
                                  width: 63,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                    borderRadius: BorderRadius.circular(
                                        30), // Half of the height/width to make it circular
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 1), // Border properties
                                    // image: DecorationImage(
                                    //   image:
                                    //   NetworkImage("http://${ipAdress}:8000/${state.contacts[index].user.image.split("\\").last}"),
                                    //   // FileImage(
                                    //   //     File(state.contacts[index].user.image)),

                                    //   fit: BoxFit
                                    //       .cover, // Stretch and fit the image within the container
                                    // ),
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://${ipAdress}:8000/${state.contacts[index].user.image.split("\\").last}",
                                      placeholder: (context, url) => Center(
                                        child: Text(
                                          capitalize(state
                                            .contacts[index].user.userName[0]), style: TextStyle(fontSize: 20, ), ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalize(state
                                            .contacts[index].user.fullName),
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 11),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.contacts[index].lastMessage,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              formatTime(
                                                  state.contacts[index].time,
                                                  "contacts"),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
                })
            : state is LoadingContacts
                ? Center(
                    child:
                        Text("Wait a moment while we fetch your contacts ..."),
                  )
                : Center(
                    child: Text("No contacts found"),
                  );
      }),
    );
  }
}
