import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaai/provider/cart_provider.dart';
import 'package:semaai/screens/nota_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> tapped = [];
  var data;

  _CartScreenState(){
     getdata();
  }


  Future getKeranjang() async {
    final String url = 'https://semai.000webhostapp.com/public/api/keranjang?user_id=1';
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }
  void getdata() async {
    final String url = 'https://semai.000webhostapp.com/public/api/keranjang?user_id=1';
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    data = json.decode(response.body);
    setState(() {

    });
  }
  void deletedata(id) async {
    final String url = 'https://semai.000webhostapp.com/public/api/keranjang/delete/${id}';
    var response = await http.get(Uri.parse(url));
    getdata();
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: const Text('Keranjang'),
        actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  data['data']['data'].length.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: FutureBuilder(
        future: getKeranjang(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return ListView.builder(
              //padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              shrinkWrap: true,
              itemCount: snapshot.data['data']['data'].length,
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
                          Image.network(snapshot.data['data']['data'][index]['semai']['Image'],
                            fit: BoxFit.cover,
                          )
                      ),
                      SizedBox(
                        width: 112,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
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
                                        '${snapshot.data['data']['data'][index]['semai']['name']}\n',
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
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
                                        '${snapshot.data['data']['data'][index]['semai']['unit']}\n',
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
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
                                        '${snapshot.data['data']['data'][index]['semai']['price']}\n',
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                       PlusMinusButtons(
                              addQuantity: () {
                                data['data']['data'][index]['jumlah']++;
                                setState(() {

                                });
                              },
                              deleteQuantity: () {
                                data['data']['data'][index]['jumlah']--;
                                setState(() {

                                });
                              },
                              text:  data['data']['data'][index]['jumlah'].toString(),
                            ),

                      IconButton(
                          onPressed: () {
                            deletedata(snapshot.data['data']['data'][index]['id']);

                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red.shade800,
                          )),
                    ],
                  ),
                ),
              );
              },
            );
          }else{
            return Text("data ga ketemu");}
        },
          
      ),
        //
        bottomNavigationBar: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotaPage())
            );
          },
          child:  Container(
            color: Colors.yellow.shade600,
            alignment: Alignment.center,
            height: 50.0,
            child: const Text(
              'Nota',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }
class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
        required this.addQuantity,
        required this.deleteQuantity,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}