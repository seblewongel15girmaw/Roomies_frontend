// import 'package:begara_mobile/feauters/house/presentation/bloc/user/payment/payment_event.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../bloc/user/payment/payment_bloc.dart';
// import '../../bloc/user/payment/payment_state.dart';
//
// class PaymentModal extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<PaymentBloc>(context).add(MakePaymentEvent(""));
//
//     return showModalBottomSheet(
//         context: context,
//         builder: (context){
//           return BlocListener<PaymentBloc, PaymentState>(
//               listener: (context, state) async{
//                 print("hey");
//                 print(state);
//                 if(state is PaymentSuccess){
//                   String? successUrl = state.successUrl;
//                   if(successUrl != null){
//                     var url=Uri.parse(successUrl);
//                     if(await canLaunchUrl(url)){
//                       launchUrl(url);
//                       // context.read<PaymentBloc>().add(PaymentStatusEvent(trx_ref));
//                     }
//                   }
//                 }
//                 print("hi");
//                 if(state is SuccessPaymentStatus){
//                   Navigator.pushNamed(context, "/brokerProfile");
//                 }
//               },
//               child:    Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: Colors.yellow,
//                         width: 1,
//                         style: BorderStyle.solid
//                     ),
//                     color: Colors.black,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:Radius.circular(20) )
//                 ),
//                 height: 250,
//                 width: MediaQuery.of(context).size.width,
//                 child:Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Pay 50 birr before viewing", style: TextStyle(color: Colors.white),),
//                     SizedBox(height: 20,),
//                     ElevatedButton(onPressed: ()async {
//                       var now = DateTime.now();
//                       var tx_ref = "chewataatiesit-6669-${now.year}-${now.month}-${now
//                           .day} ${now.hour}${now.minute}${now.second}";
//                       BlocProvider.of<PaymentBloc>(context).add(MakePaymentEvent(tx_ref));
//
//                     },
//                         child: Text("Make Payment")
//                     )],
//                 ) ,
//               ));
//         });
//
//
//   }
// }
