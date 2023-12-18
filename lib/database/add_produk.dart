// import 'dart:ui';
// import 'package:flutter/material.dart';
//
//
//
// //ProductCreatingPage
// class AddProduk extends StatefulWidget {
//   const AddProduk({Key? key}) : super(key: key);
//
//
//   @override
//   State<AddProduk> createState() => _AddProdukState();
// }
// class _AddProdukState extends State<AddProduk> {
//   final GlobalKey<State> _keyLoader = new GlobalKey<State>();
//
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController nameController = new TextEditingController();
//     final TextEditingController priceController = new TextEditingController();
//     final TextEditingController stockController = new TextEditingController();
//     final TextEditingController descriptionController =
//     new TextEditingController();
//
//
//     return MaterialApp(
//       home: Scaffold(
//         body: ListView(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   children: [],
//                 ),
//                 Expanded(
//                   child: Container(
//                       margin: EdgeInsets.fromLTRB(20, 30, 30, 20),
//                       width: 500,
//                       decoration: BoxDecoration(
//                           color: Colors.white30,
//                           borderRadius: BorderRadius.all(Radius.circular(8))),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           // for row of name and its text field
//                           Container(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // for name label
//                                 Container(
//                                   margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
//                                   height: 100,
//                                   child: Column(children: [
//                                     Text(
//                                       'Name :',
//                                       style: TextStyle(fontSize: 20),
//                                     ),
//                                   ]),
//                                 ),
//                                 // for textfield of name
//                                 Expanded(
//                                   child: Container(
//                                     margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
//                                     width: 250,
//                                     height: 85,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white30,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(8))),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         TextField(
//                                             controller: nameController,
//                                             key: Key('name_controller'),
//                                             autofocus: true,
//                                             maxLength: 20,
//                                             maxLines: 1,
//                                             textAlign: TextAlign.center,
//                                             style:
//                                             TextStyle(color: Colors.black),
//                                             decoration: InputDecoration(
//                                                 border: OutlineInputBorder()))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           // for row of name and its text field
//                           Container(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // for price label
//                                 Container(
//                                   margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
//                                   height: 100,
//                                   child: Column(children: [
//                                     Text(
//                                       'Price :',
//                                       style: TextStyle(fontSize: 20),
//                                     ),
//                                   ]),
//                                 ),
//                                 // for textfield of name
//                                 Expanded(
//                                   child: Container(
//                                     margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
//                                     width: 250,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white30,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(8))),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         TextField(
//                                             key: Key('price_controller'),
//                                             controller: priceController,
//                                             autofocus: true,
//                                             maxLength: 5,
//                                             keyboardType: TextInputType.number,
//                                             maxLines: 1,
//                                             textAlign: TextAlign.center,
//                                             style:
//                                             TextStyle(color: Colors.black),
//                                             decoration: InputDecoration(
//                                                 border: OutlineInputBorder()))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // for price label
//                                 Container(
//                                   margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
//                                   height: 100,
//                                   child: Column(children: [
//                                     Text(
//                                       'Unit :',
//                                       style: TextStyle(fontSize: 20),
//                                     ),
//                                   ]),
//                                 ),
//                                 // for textfield of name
//                                 Expanded(
//                                   child: Container(
//                                     margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
//                                     width: 250,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white30,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(8))),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         TextField(
//                                             key: Key('stock_controller'),
//                                             controller: stockController,
//                                             autofocus: true,
//                                             maxLength: 5,
//                                             maxLines: 1,
//                                             textAlign: TextAlign.center,
//                                             style:
//                                             TextStyle(color: Colors.black),
//                                             decoration: InputDecoration(
//                                                 border: OutlineInputBorder()))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ), // for row of description and its text field
//                           // for row of specification and its text field
//                         ],
//                       )),
//                 ),
//               ],
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       if (nameController.text == '' ||
//                           priceController.text == '' ||
//                           stockController.text == '' ||
//                           descriptionController.text == '') {
//                         final snackBar = SnackBar(
//                           content: Text('You must enter the whole fileds'),
//                           action: SnackBarAction(
//                             label: 'Undo',
//                             onPressed: () {
//                               // Some code to undo the change.
//                             },
//                           ),
//                         );
//                         // Find the ScaffoldMessenger in the widget tree
//                         // and use it to show a SnackBar.
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         return;
//                       }
//                     },
//                     key: Key('Create_Product'),
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white30,
//                             borderRadius: BorderRadius.all(Radius.circular(8))),
//                         padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
//                         margin: EdgeInsets.only(right: 20),
//                         child: Text(
//                           'Simpan',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.lightGreen
//                           ),
//                         )),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }