//import 'dart:html';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaai/provider/cart_provider.dart';
import 'package:semaai/screens/cart_screen.dart';
import 'package:semaai/screens/tambah_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  _ProductListState(){
    getdata();
  }

  int total=0;
  void getdata() async {
    final String url = 'https://semai.000webhostapp.com/public/api/keranjang?user_id=1';
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    total = json.decode(response.body)['data']['data'].length;
    setState(() {

    });
  }

  final String url = 'https://semai.000webhostapp.com/public/api/semai';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
}
  void tambah(int id)async{
    final response = await http.post(
      Uri.parse('https://semai.000webhostapp.com/public/api/keranjang/tambah'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': '1',
        'semai_id': id.toString(),
      }),
    );
    print(response.body);
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  total.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),

      body: 
      FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              shrinkWrap: true,
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey.shade100,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child:
                            Image.network(snapshot.data['data'][index]['Image'],
                            fit: BoxFit.cover,
                            )
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: TextSpan(
                                    text: 'Name: ',
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 10.0),
                                    children: [
                                      TextSpan(
                                          text:
                                          snapshot.data['data'][index]['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                              RichText(
                                maxLines: 1,
                                text: TextSpan(
                                    text: 'Unit: ',
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 10.0),
                                    children: [
                                      TextSpan(
                                          text:
                                          snapshot.data['data'][index]['unit'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                              RichText(
                                maxLines: 1,
                                text: TextSpan(
                                    text: 'Price: ' r"Rp ",
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 10.0),
                                    children: [
                                      TextSpan(
                                          text:
                                          snapshot.data['data'][index]['price'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green.shade900),
                            onPressed: () {
                              tambah(snapshot.data['data'][index]['id']);
                              // saveData(index);
                            },
                            child: const Text('Add to Cart')),
                      ],
                    ),
                  ),
                );
              },
            );
            }else{
            return Text("data ga ketemu");}
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: Icon(Icons.add,
          color: Colors.white,
        ),

      ),
    );
  }
}