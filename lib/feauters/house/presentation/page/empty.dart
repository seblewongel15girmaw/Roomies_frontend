// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:flutter/material.dart';
//
// class EmptyPage extends StatefulWidget{
//   @override
//   State<EmptyPage> createState() => _EmptyPageState();
// }
//
// class _EmptyPageState extends State<EmptyPage> {
//   @override
//   Widget build(BuildContext context) {
//     var index;
//    return Scaffold(
//      backgroundColor: Colors.black87,
//      bottomNavigationBar: CurvedNavigationBar(
//        backgroundColor: Colors.black,
//        color: Colors.white24,
//        animationDuration: Duration(milliseconds: 500),
//        buttonBackgroundColor: Color.fromRGBO(244, 196, 48,0.9),
//        onTap: (idx){
//          setState(() {
//            index=idx;
//          });
//        },
//        items: [
//          CurvedNavigationBarItem(child:  Icon(Icons.home, color: Colors.white,), label: "home"),
//          CurvedNavigationBarItem(child:  Icon(Icons.comment, color: Colors.white),label: "comment"),
//          CurvedNavigationBarItem(child:  Icon(Icons.link_rounded, color: Colors.white),label: "link"),
//          CurvedNavigationBarItem(child:  Icon(Icons.person, color: Colors.white),label: "person")
//        ],
//      ),
//      appBar: AppBar(
//        elevation: 0,
//        backgroundColor: Color.fromRGBO(244, 196, 48,0.9),
//      ),
//      drawer: Drawer(
//        surfaceTintColor: Colors.black87,
//      ),
//      body: Center(
//          child: Container(
//            width: MediaQuery.of(context).size.width*0.7,
//            // height: MediaQuery.of(context).size.height/2,
//              child: Image.network("https://cdn3d.iconscout.com/3d/premium/thumb/error-404-8808967-7122236.png",
//              fit: BoxFit.contain,))),
//    );
//   }
// }
//
//
//
//
// // no message image
// // "https://cdni.iconscout.com/illustration/premium/thumb/no-message-8580708-6763422.png?f=webp"
//
//
// // no list image
// // "https://cdn3d.iconscout.com/3d/premium/thumb/empty-box-7860352-6318310.png?f=webp"
//
//
// //network error image
// // "https://cdn3d.iconscout.com/3d/premium/thumb/no-internet-network-signal-6105260-5023504.png?f=webp"