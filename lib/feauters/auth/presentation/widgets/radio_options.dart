import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/others/radioOptions/radio_bloc.dart';
import '../bloc/others/radioOptions/radio_event.dart';
import '../bloc/others/radioOptions/radio_state.dart';

class RadioListWidget extends StatelessWidget {
  final String question;
  final List<String> values;
   String currentValue;

   RadioListWidget({
    Key? key,
    required this.question,
    required this.values,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioBloc, RadioState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question, style: TextStyle(fontSize: 14, color: Colors.black)),
                SizedBox(height: 8),
                Column(
                  children: values.map((value) {
                    return RadioListTile(
                      activeColor: const Color.fromARGB(255, 187, 148, 48),
                      title: Text(value),
                      value: value,
                      groupValue: currentValue,
                      onChanged: (selectedValue) {
                        currentValue=selectedValue!;
                        BlocProvider.of<RadioBloc>(context).add(RadioEvent());
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}