import 'dart:io';
import 'package:begara_mobile/core/util/validators.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/others/image/image.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/profile/profile.dart';
import 'package:begara_mobile/feauters/auth/presentation/strings.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/error_message.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/text_fields.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/drop_down_option.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/submit_button.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/location_bar.dart';

class ProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  XFile? image;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController jobStatus = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController budget = TextEditingController();
    XFile? image2;
    bool profileSelected = false;
    bool idSelected = false;
    String? religion;
    Location? address;
    String gender = "";
    String pet = "";
    String religiousSimilarity = "";
    String privacy = "";
    String socialize = "";
    String smoking = "";
  @override
  Widget build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SingleChildScrollView(
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
                            : Icon(
                                Icons.account_circle,
                                size: 100,
                                color: Color.fromARGB(255, 187, 148, 48),
                              ),
                      ),
                      IconButton(
                        key:Key("profile_image_upload"),
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
                      // CustomDropdownButton(
                      //   initalSelection: null,
                      //   items: locations,
                      //   value: address,
                      //   hintText: "Address",
                      //   onChanged: (String? newValue) {
                      //     address = newValue;
                      //   },
                      //   leadIcon: Icons.location_on,
                      // ),
                      LocationBar(getLocation: (location) {
                            address=location;
                          },width: screenWidth,
                          choosenLocation: null,),

                      CustomTextField(
                        inputKey: const Key("profile_phone"),
                        controller: phoneNumber,
                        labelText: "Phone Number",
                        prefixIcon: Icons.phone,
                        validator: phoneNumberValidator,
                      ),
                      CustomTextField(
                        inputKey: const Key("profile_age"),
                        controller: age,
                        labelText: "Age",
                        prefixIcon: Icons.calendar_month,
                        validator: ageValidator,
                      ),
                      CustomTextField(
                        inputKey: const Key("profile_budget"),
                        controller: budget,
                        labelText: "Budget",
                        prefixIcon: Icons.money,
                        validator: budgetValidator,
                      ),
                      CustomTextField(
                        inputKey: const Key("profile_job"),
                          controller: jobStatus,
                          labelText: "Job Status",
                          prefixIcon: Icons.cases),
                      SizedBox(
                        height: 20,
                      ),
                      CustomDropdownButton(
                        initalSelection: null,
                        key: Key("profile_religion"),
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
                        initalSelection: null,
                        key: Key("gender_dropdown"),
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
                        initalSelection: null,
                        key: Key("profile_religious_similarity"),
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
                        initalSelection: null,
                        key: Key("smoking"),
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
                        initalSelection: null,
                        key: Key("pet"),
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
                        initalSelection: null,
                        key: Key("punctuality"),
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
                        initalSelection: null,
                        key: Key("socialize"),
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
                        key: Key("profile_id_upload"),
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
                        key: Key("bio"),
                        maxLines: 4,
                        controller: bio,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 30),
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
                            buttonKey: const Key("profile_btn"),
                              bloc: BlocProvider.of<ProfileBloc>(context),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(address);
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
                              buttonText: "NEXT",
                              listener: (context, state) {
                                 if (state is CreateSuccess) {
                          Navigator.pushNamed(context, '/guarantor',);
                      }
                              },
                              success: CreateSuccess,
                              fail: CreateFailed,
                              progress: Creating)),
                    ]),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
