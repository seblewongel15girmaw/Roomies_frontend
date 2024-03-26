import 'package:begara_mobile/blocks/profile/gender_bloc.dart';
import 'package:begara_mobile/blocks/profile/gender_event.dart';
import 'package:begara_mobile/blocks/profile/gender_state.dart';
import 'package:begara_mobile/blocks/profile/profile_bloc.dart';
import 'package:begara_mobile/blocks/profile/profile_event.dart';
import 'package:begara_mobile/blocks/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  TextEditingController address= TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController jobStatus=TextEditingController();
  TextEditingController bio=TextEditingController();
  String gender="";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ProfileBloc,ProfileState>(
        builder: (context,state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Icon(Icons.account_circle,size:100,color: Color.fromARGB(255, 187, 148, 48),),
                      Icon(Icons.camera_alt_outlined, size: 20, color: Color.fromARGB(255, 217, 148, 48),)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          controller: address,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_pin),
                            prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                            labelText: "Adress",
                          ),
                        ),
                      ),
                  
                       Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                            labelText: "Phone Number",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          controller: age,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_month),
                            prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                            labelText: "Age",
                          ),
                        ),
                      ),
                  
                       Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          controller: jobStatus,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.cases),
                            prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                            labelText: "Job Status",
                          ),
                        ),
                      ),
            
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, right:30),
                        child: Text("Gender", style: TextStyle(fontSize: 17,color: Colors.white),),
                      ),
                     
                      Padding(
                        padding: EdgeInsets.only(left: 40,right: 30),
                        child: BlocBuilder<RadioBloc,RadioState> (
                          builder: (context,state) {
                            return Row(
                                          
                              children:<Widget> [
                                Expanded(
                                  child: RadioListTile(
                                    
                                    activeColor: Colors.white,
                                    title: Text("Male"),
                                    value: "male",
                                    groupValue:state is MaleSelected?"male":"",
                                    onChanged: (value){
                                      gender=value!;
                                      BlocProvider.of<RadioBloc>(context).add(RadioEvent(value));
                                    },
                                          
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    activeColor: Colors.white,
                                    title: Text("Female"),
                                    value: "female",
                                    groupValue: state is FemaleSelected?"female":"",
                                    onChanged: (value){
                                      gender=value!;
                                      BlocProvider.of<RadioBloc>(context).add(RadioEvent(value));
                                    },
                                          
                                  ),
                                )
                              ],
                            );
                          }
                        ),
                      ),
                      
                      SizedBox(
                        height: 20,
                      ),
                      Padding(padding: EdgeInsets.only(left: 30,),
                              child: Text("Bios", style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
            
                              ),),),
                      SizedBox(height: 10,),
                       Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                         child: TextField(
                          controller: bio,
                                 decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                                   hintText: 'Share something about yourself',
                                   border: OutlineInputBorder(
                                     borderSide: BorderSide(width: 2,color: Color.fromARGB(255, 187, 148, 48),style: BorderStyle.solid),
                                     borderRadius: BorderRadius.circular(0.0),
                                     
                                   ),
                                   filled: true,
                                   fillColor: Colors.black,
                                 ),
                               ),
                       ),
                       SizedBox(
                        height: 20,
                       ),
                       Center(
                         child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 20),
                            backgroundColor: Color.fromARGB(255, 187, 148, 48),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                             ),
                          ),
                          onPressed: (){
                                         BlocProvider.of<ProfileBloc>(context).add(
                       ProfileEvent(address.text,bio.text,phoneNumber.text,int.parse(age.text),jobStatus.text,gender)   
                        );
                                         }, child: state is Creating? CircularProgressIndicator() : state is CreateSuccess?
            
                   Text("Success",style: TextStyle(color: Colors.green),):state is CreateFailed? Text("Failed",style: TextStyle(color: Colors.red),):Text("Next")),
                       ),
            
              ],
            
            ),
          );
        }
      ),
    );
  }

}