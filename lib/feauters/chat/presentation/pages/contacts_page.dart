import 'dart:io';

import 'package:begara_mobile/feauters/chat/presentation/utils/functions.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/contacts/contacts.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "All Chats",
      //     style: TextStyle(
      //         color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   backgroundColor: Color.fromARGB(255, 187, 148, 48), // Make the app bar transparent
      //   elevation: 0,
      // ),
      body: BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
        if (state is Idle) {
          BlocProvider.of<ContactsBloc>(context).add(ContactsEvent());
        }
        return state is LoadingContactsSuceess
            ? ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/chat", arguments: {"user":state.contacts[index].user, "userId":state.userId});
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
                                    borderRadius: BorderRadius.circular(
                                        30), // Half of the height/width to make it circular
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 1), // Border properties
                                    image: DecorationImage(
                                      image: FileImage(
                                          File(state.contacts[index].user.image)),
                                      fit: BoxFit
                                          .cover, // Stretch and fit the image within the container
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalize(
                                            state.contacts[index].user.fullName),
                                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 11),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text(
                                          state.contacts[index].lastMessage,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          formatTime(state.contacts[index].time,"contacts"),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        ]
                                      ),
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
                    child: Text("Wait a moment while we fetch your contacts"),
                  )
                : Center(
                    child: Text("No contacts found"),
                  );
      }),
    );
  }
}
