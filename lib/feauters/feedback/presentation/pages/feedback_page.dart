import 'package:begara_mobile/feauters/feedback/presentation/blocs/chip/chip.dart';
import 'package:begara_mobile/feauters/feedback/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:begara_mobile/feauters/feedback/presentation/blocs/feedback/feedback_event.dart';
import 'package:begara_mobile/feauters/feedback/presentation/blocs/feedback/feedback_state.dart';
import 'package:begara_mobile/feauters/feedback/presentation/widget/chip_widget.dart';
import 'package:begara_mobile/feauters/feedback/presentation/widget/rating_bar.dart';
import 'package:begara_mobile/feauters/feedback/presentation/widget/success_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final double rating = 2.5;
  final TextEditingController feedbackMessageController =
      TextEditingController();
  List<String> feedbackCategory = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("FeedBack"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor:Color.fromRGBO(244, 196, 48,0.9) , // Make the app bar transparent
          elevation: 0,
        ),
      body: BlocBuilder<FeedBackBloc, FeedBackState>(builder: (context, state) {
        if (state is !FeedBackSuccess) {
          return Column(
            children: [
              RatingBarCard(size: size, rating: rating),
              Chips(size: size, feedbackCategory: feedbackCategory),
              Container(
                width: size.width,
                child: Card(
                  color: Color.fromRGBO(247, 228, 171, 0.898),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tell us more: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: TextField(
                                
                                maxLines: 4,
                                controller: feedbackMessageController,
                                decoration: InputDecoration(
                                
                                  contentPadding: EdgeInsets.only(top:30,left: 10,right: 10),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                  hintText: 'Share something about yourself',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 187, 148, 48),
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                key: Key("send_feedback"),
                onTap: () {
                  BlocProvider.of<FeedBackBloc>(context).add(SendFeedBackEvent(
                      feedbackMessage: feedbackMessageController.text,
                      feedbackCategory: feedbackCategory,
                      rating: rating));
                },
                child: Container(
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                    color:  Color.fromRGBO(244, 196, 48,0.9),
                      border: Border.all(width: 2, color: Colors.amber)),
                  child: Center(
                    child: state is SendingFeedBack
                        ? CircularProgressIndicator()
                        : state is FeedBackFailed
                            ? Text("Retry")
                            : Text("Submit"),
                  ),
                ),
              )
            ],
          );
        } else {
          return SuccessMessageModal();
        }
      }),
    );
  }
}
