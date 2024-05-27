import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/chip/chip.dart';

class Chips extends StatelessWidget{

  final Size size;
  List <String> feedbackCategory;
  Chips({required this.size, required this.feedbackCategory});
  @override
  Widget build(BuildContext context) {
    List<String> labels = [
    "Service",
  "Appearance",
  "Speed",
  "Security",
  "Update",
  "User Support",
  "Functionality",
  "Ease of Use",
  "Compatibility",
  "Reliability",
  "Customizability",
  "Documentation",
  ];
  List<bool> selected = List<bool>.filled(12, false);
  
    return Container(

            width: size.width,
            child: Card(
              color: Color.fromRGBO(247, 228, 171, 0.898),
              child: Padding(
                padding:  EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                child: Column(
                  
                  children: [
                    Text("What should be improved", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    Container(child: BlocBuilder<ChipBloc,ChipState>(builder: (context, state) {
                      
                      return Wrap(
                        spacing: 7.0,
                        runSpacing: 6.0,
                        children:
                            List<Widget>.generate(labels.length, (int index) {
                          return FilterChip(
                            label: Text(labels[index]),
                            selected: selected[index],
                            onSelected: (bool isSelected) {
                              selected[index] = !selected[index];
                              if(feedbackCategory.contains(labels[index])){
                                feedbackCategory.remove(labels[index]);
                              }
                              else{
                                feedbackCategory.add(labels[index]);
                              }
                              print(feedbackCategory);
                              BlocProvider.of<ChipBloc>(context).add(SelectChipEvent(selected[index]));
                            },
                          );
                        }),
                      );
                    }))
                  ],
                ),
              ),
            ),
          ); 
  }

}