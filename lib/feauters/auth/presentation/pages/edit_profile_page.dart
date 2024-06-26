import 'dart:io';
import 'package:begara_mobile/core/util/validators.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/users_profile/user_profile.dart';
import 'package:begara_mobile/feauters/auth/presentation/strings.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/error_message.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/location_bar.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/text_fields.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/drop_down_option.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/submit_button.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class EditProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  XFile? image;
    XFile? image2;
    Location? location;
    bool profileSelected = false;
    bool idSelected = false;
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController age = TextEditingController();
    TextEditingController jobStatus = TextEditingController();
    TextEditingController bio = TextEditingController();
    TextEditingController budget = TextEditingController();
    String? religion;
    Location? address;
    String gender = "";
    String pet = "";
    String religiousSimilarity = "";
    String privacy = "";
    String socialize = "";
    String smoking = "";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserProfileBloc>(context).add(UserProfileEvent(0));
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: BlocBuilder<UserProfileBloc,UserProfileState>(
        builder: (context,state) {
          
          if(state is UserProfileSuccess){
            final user= state.user;
            print(user);
            phoneNumber.text=user.phoneNumber;
            age.text=user.age.toString();
            jobStatus.text=user.jobStatus;
            bio.text=user.bio;
            budget.text=user.budget.toString();
            address=user.address;
            religion=user.religion;
            gender=user.gender;
            pet=user.pet;
            religiousSimilarity = user.religiousSimilarity;
            privacy = user.privacy;
            socialize = user.socialize;
            smoking = user.smoking;
            image=XFile(user.image);
            image2=XFile(user.image2);
            
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Column(children: [
                  Center(
                    child: BlocConsumer<ImageBloc, ImageState>(
                        listener: (context, state) {
                      if (state is ImageSelected) {
                        image = state.image;
                      }
                    }, builder: (context, state) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: profileSelected
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(File(image!.path)),
                                            fit: BoxFit.fill)),
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(File(user.image)),
                                            fit: BoxFit.fill)),
                                  )
                          ),
                          IconButton(
                            icon: Icon(Icons.camera_alt_outlined,
                                size: 20, color: Color.fromARGB(255, 217, 148, 48)),
                            onPressed: () {
                              profileSelected = true;
                              BlocProvider.of<ImageBloc>(context)
                                  .add(ProfileClicked());
                            },
                          )
                        ],
                      );
                    }),
                  ),
                  ErrorMessage(image: "image"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          LocationBar(getLocation: (location) {
                            print(location);
                            address=location;
                          },width: screenWidth,
                          choosenLocation: address!.displayName,
                          ),
                          // CustomDropdownButton(
                          //   initalSelection: address.displayName ==""?null:address,
                          //   items: locations,
                          //   value: address,
                          //   hintText: "Address",
                          //   onChanged: (String? newValue) {
                          //     address = newValue;
                          //   },
                          //   leadIcon: Icons.location_on,
                          // ),
                          CustomTextField(
                            controller: phoneNumber,
                            labelText: "Phone Number",
                            prefixIcon: Icons.phone,
                            validator: phoneNumberValidator,
                            inputKey: Key("edit_phone"),
                          ),
                          CustomTextField(
                            controller: age,
                            labelText: "Age",
                            prefixIcon: Icons.calendar_month,
                            validator: ageValidator,
                            inputKey: Key("edit_age"),
                          ),
                          CustomTextField(
                            controller: budget,
                            labelText: "Budget",
                            prefixIcon: Icons.money,
                            validator: budgetValidator,
                            inputKey: Key("edit_budget"),
                          ),
                          CustomTextField(
                              controller: jobStatus,
                              labelText: "Job Status",
                              prefixIcon: Icons.cases,
                            inputKey: Key("edit_job_status"),),
                          SizedBox(
                            height: 20,
                          ),
                          CustomDropdownButton(
                            initalSelection: religion==""?null:religion,
                            items: ProfilePageStrings.religionItems,
                            value: religion,
                            hintText: "Choose Religion",
                            onChanged: (String? newValue) {
                              religion = newValue;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomDropdownButton(
                            initalSelection: gender==""?null:gender,
                            leadIcon: Icons.note_alt_sharp,
                            hintText: "Choose your gender",
                            header: "Gender",
                            items: ProfilePageStrings.genderItems,
                            value: gender,
                            onChanged: (newValue) {
                              gender = newValue!;
                            },
                          ),
                          CustomDropdownButton(
                            initalSelection: religiousSimilarity==""?null:religiousSimilarity,
                            leadIcon: Icons.note_alt_sharp,
                            hintText: "",
                            header:
                                "Are you comfortable living with someone of a different religion?",
                            items: ProfilePageStrings.religiousSimilarityItems,
                            value: religiousSimilarity,
                            onChanged: (newValue) {
                              religiousSimilarity = newValue!;
                            },
                          ),
                          CustomDropdownButton(
                            initalSelection: smoking==""?null:smoking,
                            leadIcon: Icons.note_alt_sharp,
                            header:
                                "Do you smoke or are you okay with living with someone who does?",
                            items: ProfilePageStrings.smokingItems,
                            value: smoking,
                            hintText: "",
                            onChanged: (newValue) {
                              smoking = newValue!;
                            },
                          ),
                          CustomDropdownButton(
                            initalSelection: pet==""?null:pet,
                            leadIcon: Icons.note_alt_sharp,
                            header: "Are you pet-friendly?",
                            items: ProfilePageStrings.petItems,
                            value: pet,
                            hintText: "",
                            onChanged: (newValue) {
                              pet = newValue!;
                            },
                          ),
                          CustomDropdownButton(
                            initalSelection: privacy==""?null:privacy,
                            leadIcon: Icons.note_alt_sharp,
                            header:
                                "Can you tolerate roommates who arrive late for various reasons?",
                            items: ProfilePageStrings.privacyItems,
                            value: privacy,
                            hintText: "",
                            onChanged: (newValue) {
                              privacy = newValue!;
                            },
                          ),
                          CustomDropdownButton(
                            initalSelection: socialize==""?null:socialize,
                            leadIcon: Icons.note_alt_sharp,
                            header: "How often do you socialize at home?",
                            items: ProfilePageStrings.socializeItems,
                            value: socialize,
                            hintText: "",
                            onChanged: (newValue) {
                              socialize = newValue!;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          UploadImageButton(
                            idImage: image2,
                            onPressed: () {
                              BlocProvider.of<ImageBloc>(context).add(IdClicked());
                            },
                            listener: (context, state) {
                              if (state is IdSelected) {
                                image2 = state.image2;
                              }
                            },
                          ),
                          ErrorMessage(image: "image2"),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Bios",
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 187, 148, 48),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 4,
                            controller: bio,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 30,left: 10,right: 5),
                              hintStyle: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w100),
                              hintText: 'Share something about yourself',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 187, 148, 48),
                                    style: BorderStyle.solid),
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
                              child: SubmitButton(
                                  bloc: BlocProvider.of<ProfileBloc>(context),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<ProfileBloc>(context).add(
                                          ProfileEvent(
                                              address: address!,
                                              bio: bio.text,
                                              phoneNumber: phoneNumber.text,
                                              age: int.parse(age.text),
                                              jobStatus: jobStatus.text,
                                              religion: religion!,
                                              gender: gender,
                                              image: image!,
                                              image2: image2!,
                                              budget: int.parse(budget.text),
                                              smoking: smoking,
                                              pet: pet,
                                              privacy: privacy,
                                              religiousSimilarity:
                                                  religiousSimilarity,
                                              socialize: socialize));
                                    }
                                  },
                                  buttonText: "Update Profile",
                                  listener: (context, state) {
                                     if (state is CreateSuccess) {
                              Navigator.pushNamed(context, '/guarantor',);
                          }
                                  },
                                  success: CreateSuccess,
                                  fail: CreateFailed,
                                  progress: Creating,
                                buttonKey: Key("profile_edit_btn"))),
                        ]),
                      ),
                    ),
                  ),
                ])
              ],
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        }
      
      ),
    );
  }
}
