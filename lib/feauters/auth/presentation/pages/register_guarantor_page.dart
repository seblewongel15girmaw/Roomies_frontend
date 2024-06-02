import 'package:begara_mobile/core/util/validators.dart';
import 'package:begara_mobile/feauters/auth/domain/Entities/location.dart';
import 'package:begara_mobile/feauters/auth/presentation/bloc/guarantor/guarantor.dart';
import 'package:begara_mobile/feauters/auth/presentation/strings.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/error_message.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/location_bar.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/text_fields.dart';
import 'package:begara_mobile/feauters/auth/presentation/widgets/upload_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/util/locations.dart';
import '../bloc/others/image/image.dart';
import '../widgets/drop_down_option.dart';
import '../widgets/submit_button.dart';

class RegisterGuarantorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size screenSize = MediaQuery.of(context).size;
    TextEditingController fullName = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    String gender = "";
    XFile? image2;
    Location? address;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.12,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 187, 148, 48),
              ),
              child: Center(
                child: Text(
                  "Guarantor Form",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Please fill the following form about Your Guarantor (a person accountable for ones action)",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        inputKey: const Key("guarantor_name"),
                        controller: fullName,
                        labelText: "Full Name",
                        prefixIcon: Icons.person,
                        validator: nameValidator,
                      ),
                      CustomTextField(
                        inputKey: const Key("guarantor_phone"),
                        controller: phoneNumber,
                        labelText: "Phone Number",
                        prefixIcon: Icons.phone,
                        validator: phoneNumberValidator,
                      ),
                      SizedBox(height: 20,),
                      LocationBar(getLocation: (location) {
                        address=location;
                      }, width: screenSize.width,
                      choosenLocation: null,),
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
                     
                      CustomDropdownButton(
                        initalSelection: null,
                        leadIcon: Icons.note_alt_sharp,
                        hintText: "Choose gender",
                        header: "Gender",
                        items: ProfilePageStrings.genderItems,
                        value: gender,
                        onChanged: (newValue) {
                          gender = newValue!;
                        },
                      ),
                      SizedBox(
                        height: 30,
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
                        height: 45,
                      ),
                      SubmitButton(
                          buttonKey: const Key("guarantor_btn"),
                          bloc: BlocProvider.of<GuarantorBloc>(context),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<GuarantorBloc>(context)
                                  .add(GuarantorEvent(
                                address: address!,
                                phoneNumber: phoneNumber.text,
                                gender: gender,
                                profileImage: image2!,
                                fullName: fullName.text,
                              ));
                            }
                          },
                          buttonText: "Complete",
                          listener: (context, state) {
                            if (state is CreateSuccess) {
                              Navigator.pushNamed(context, "/homePage");
                            }
                          },
                          success: CreateSuccess,
                          fail: CreateFailed,
                          progress: Creating),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
