import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarCard extends StatelessWidget{
  final Size size;
  double rating;
  RatingBarCard({required this.size, required this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
            width: size.width,
            child: Card(
              color: Color.fromRGBO(247, 228, 171, 0.898),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Text(
                      "Rate your Experience",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Are you enjoying our app?"),
                    SizedBox(
                      height: 5,
                    ),
                    RatingBar.builder(
                        itemSize: 25,
                        initialRating: 2.5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemBuilder: (context, _) {
                          return Icon(
                            key: Key("rating_icon"),
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (rate) {
                          rating = rate;
                        })
                  ],
                ),
              ),
            ),
          );
  }

}