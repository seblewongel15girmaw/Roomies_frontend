import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_bloc.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_event.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/bloc/roommate/roommate_state.dart';
import 'package:begara_mobile/feauters/recommendation/presentation/widgets/match_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayMatchesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Compatable Roommates",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                "Discover your perfect matches! 🎉 We believe these individuals would make an excellent fit for you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          BlocBuilder<RoommateBloc, RoommateState>(
            builder: (context, state) {
              if(state is Idle){
                BlocProvider.of<RoommateBloc>(context)
                                        .add(RoommateEvent());
              }
              return Container(
                  child: state is LoadSuccess
                      ? Expanded(child: MatchList(state.roommmates))
                      : state is LoadFailed
                          ? Text("error has been caused")
                          : state is Loading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<RoommateBloc>(context)
                                        .add(RoommateEvent());
                                  },
                                  child: Text("see matches")));
            },
          )
        ],
      ),
    );
  }
}
