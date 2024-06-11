import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/env.dart';
import '../../../../auth/presentation/bloc/logout/logout.dart';
import '../../../../auth/presentation/bloc/users_profile/user_profile.dart';

class CustomDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
            backgroundColor:Color.fromRGBO(209, 175, 74, 1),
            child: ListView(children: [
              SizedBox(height: 35),
              BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileSuccess) {
                    print("it is indeed");
                    final user = state.user;
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "http://${ipAdress}:8000/${user.image.split("\\").last}"),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://www.vkmetalwoodcraft.com/images/team.png"),
                    );
                  }
                },
              ),
              SizedBox(
                height: 13,
              ),
              Divider(),
              SizedBox(
                height: 25,
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.settings),
                title: Text(
                  "Setting",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.notifications),
                title: Text("Notification", style: TextStyle(fontSize: 13)),
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.color_lens),
                trailing: Icon(Icons.toggle_off_outlined),
                title: Text("Theme", style: TextStyle(fontSize: 13)),
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.help),
                title: Text("Help", style: TextStyle(fontSize: 13)),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/change-password");
                  // scaffoldKey.currentState!.openEndDrawer();
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.key),
                title:
                    Text("Change Credentials", style: TextStyle(fontSize: 13)),
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.info),
                title: Text("About Us", style: TextStyle(fontSize: 13)),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/give-feedback");
                  // scaffoldKey.currentState!.openEndDrawer();
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.feedback_sharp),
                title:
                    Text("Feedback and rate", style: TextStyle(fontSize: 13)),
              ),
              ListTile(
                onTap: () {
                  BlocProvider.of<LogoutBloc>(context).add(LogoutEvent());
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.logout),
                title: Text("Sign Out", style: TextStyle(fontSize: 13)),
              ),
              BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, state) {
                if (state is UserProfileSuccess) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      final state = context.read<UserProfileBloc>().state;
                      if (state is UserProfileSuccess) {
                        Navigator.pushNamed(context, "/deactivate",
                            arguments: state.user);
                      } else {
                        Navigator.pushNamed(context, "/deactivate",
                            arguments: []);
                      }
                    },
                    iconColor: state.user.activateStatus == 1
                        ? Colors.red
                        : Colors.green,
                    textColor: state.user.activateStatus == 1
                        ? Colors.red
                        : Colors.green,
                    leading: state.user.activateStatus == 1
                        ? Icon(Icons.remove_circle)
                        : Icon(Icons.add_circle),
                    title: state.user.activateStatus == 1
                        ? Text("Deactivate Account",
                            style: TextStyle(fontSize: 13))
                        : Text("Activate Account",
                            style: TextStyle(fontSize: 13)),
                  );
                } else {
                  return ListTile();
                }
              })
            ]));
  }

}