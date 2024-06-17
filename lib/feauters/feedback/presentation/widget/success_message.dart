import 'package:flutter/material.dart';

class SuccessMessageModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
        Icon(
          Icons.thumb_up_sharp,
          size: 100,
          color: Color.fromRGBO(244, 196, 48,0.9),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "We greatly appreciate your feedback. Thank you for sharing it with us.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/homePage");
          },
          child: Container(
            
            width: 250,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 196, 48,0.9),
                border: Border.all(width: 2, color: Colors.amber)),
            child: Center(child: Text("Return to home")),
          ),
        )
      ],
    );
  }
}
