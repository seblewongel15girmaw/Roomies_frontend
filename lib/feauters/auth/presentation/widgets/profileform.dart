import 'dart:io';
import 'package:begara_mobile/feauters/auth/presentation/bloc/gender_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/gender_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/gender_state.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/image_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/image_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/image_state.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile_bloc.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile_event.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileForm extends StatelessWidget{
  XFile? image;
  XFile? image2;
  ProfileForm({super.key} );
  @override
  Widget build(BuildContext context) {
    TextEditingController address= TextEditingController();
    TextEditingController phoneNumber=TextEditingController();
    TextEditingController age=TextEditingController();
    TextEditingController jobStatus=TextEditingController();
    TextEditingController bio=TextEditingController();
    TextEditingController budget=TextEditingController();
    
    String gender="";
    bool profileSelected=false;
    bool idSelected=false;
    return Column(
      children: [Center(
                  child: BlocConsumer<ImageBloc,ImageState>(
                    listener: (context,state){
                      if(state is ImageSelected){
                        image=state.image;
                      }
                    },
                    builder: (context,state) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child:profileSelected? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: FileImage(File(image!.path)),fit:BoxFit.fill  )
                              ),
                            ):Icon(Icons.account_circle,size:100,color: Color.fromARGB(255, 187, 148, 48),),
                          ),
                          IconButton(icon:Icon(Icons.camera_alt_outlined, size: 20, color: Color.fromARGB(255, 217, 148, 48)) ,
                          onPressed: (){
                            profileSelected=true;
                            BlocProvider.of<ImageBloc>(context).add(ProfileClicked());
                          },)
                        ],
                      );
                    }
                  ),
                ),
            SizedBox(
              height: 20,
            ),
        Padding(
                          padding: EdgeInsets.only(left: 30,right: 30),
                          child: Column(
                            children:<Widget>[ 
                              TextFormField(
                              controller: address,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_pin),
                                prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                                labelText: "Adress",
                              ),
                            ),
                            TextFormField(
                           controller: phoneNumber,
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.phone),
                             prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                             labelText: "Phone Number",
                           ),
                         ),
                        TextFormField(
                          controller: age,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_month),
                            prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                            labelText: "Age",
                          ),
                        ),
                        TextFormField(
                          controller: budget,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.money),
                            prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                            labelText: "Budget",
                          ),
                        ),
      
                         TextFormField(
                           controller: jobStatus,
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.cases),
                             prefixIconColor:Color.fromARGB(255, 187, 148, 48), 
                             labelText: "Job Status",
                           ),
                         ),
              
              
                        SizedBox(
                          height: 20,
                        ),
                        Text("Gender", style: TextStyle(fontSize: 17,color: Colors.black),),
                        BlocBuilder<RadioBloc,RadioState> (
                            builder: (context,state) {
                              return Row(
                                            
                                children:<Widget> [
                                  Expanded(
                                    child: RadioListTile(
                                      
                                      activeColor: Colors.black,
                                      title: Text("Male"),
                                      value: "male",
                                      groupValue:state is MaleSelected?"male":"",
                                      onChanged: (value){
                                        gender=value!;
                                        BlocProvider.of<RadioBloc>(context).add(RadioEvent(gender));
                                      },
                                            
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      activeColor: Colors.black,
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
      
                      SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<ImageBloc,ImageState>(
                          listener: (context,state){
                            if (state is IdSelected){
                              image2=state.image2;
                            }
                          },
                           builder: (context,state) {
                             return ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 fixedSize: Size(500 ,20),
                                 backgroundColor:idSelected?Color.fromARGB(255, 241, 216, 152) : Color.fromARGB(255, 187, 148, 48),
                                 foregroundColor: Colors.black,
                                 shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                                  ),
                               )
                               ,onPressed: (){
                                
                                idSelected=true;
                                BlocProvider.of<ImageBloc>(context).add(
      
                                  IdClicked()
                                );
                               }, child: 
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Icon(Icons.upload),
                                 Text("Upload Id")
                               ],
                             ));
                           }
                         ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Bios", style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                                    
                        ),),
                        SizedBox(height: 10,),
                         TextField(
                          controller: bio,
                                 decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                                   hintText: 'Share something about yourself',
                                   border: OutlineInputBorder(
                                     borderSide: BorderSide(width: 2,color: Color.fromARGB(255, 187, 148, 48),style: BorderStyle.solid),
                                     borderRadius: BorderRadius.circular(0.0),
                                     
                                   ),
                                   filled: true,
                                   fillColor: Colors.white,
                                 ),
                               ),
                         SizedBox(
                          height: 20,
                         ),
                         Center(
                           child: BlocBuilder<ProfileBloc,ProfileState>(
                             builder: (context,state) {
                               return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(200, 20),
                                  backgroundColor:state is Creating? Colors.grey:state is CreateFailed? Colors.red: state is CreateSuccess? 
                                  Colors.green:Colors.amber,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                                   ),
                                ),
                                onPressed: (){
                                  BlocProvider.of<ProfileBloc>(context).add(ProfileEvent(address.text, bio.text, phoneNumber.text,int.parse(age.text), jobStatus.text, gender, image!,
                                  int.parse(budget.text), image2!));
                                               }, child: Text("Next"));
                             }
                           ),
                         ), 
                            ]
                          ),
                        ),]
    );
                            
                      
  }

}