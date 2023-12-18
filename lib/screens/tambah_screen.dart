import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:semaai/screens/product_list.dart';
import 'dart:convert';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final _formKey = GlobalKey <FormState>();
  final _nameController = TextEditingController();
  final _unitController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  Future saveProduct() async {
    final response =
      await http.post(Uri.parse('https://semai.000webhostapp.com/public/api/semai/store'),body:  {
        "name":_nameController.text,
        "unit":_unitController.text,
        "price":_priceController.text,
        "image":_imageController.text,
    });

    print(response.body);

    return json.decode(response.body);
  }
  void update(int id)async{
    final response = await http.post(
      Uri.parse('https://semai.000webhostapp.com/public/api/semai/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': _nameController.text,
        'unit': _unitController.text,
        'price': _priceController.text,
        'image': _imageController.text,
      }),
    );
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"), backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              key: Key('_nameController'),
              decoration: const InputDecoration(
                labelText: "Nama",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return "input nama produk";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _unitController,
              decoration: const InputDecoration(
                labelText: "Unit",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return "input unit produk";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: "Harga",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if (value!.isEmpty) {
                  return "input harga produk";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: "Gambar",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return "input gambar produk";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                //if (_formKey.currentState!.validate()) {
                //   if (_formKey.currentState != null) {
                //     _formKey.currentState.validate();
                  saveProduct().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProductList()));
                  });
                }
              },
              child: Text("Simpan"), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightGreen)), )
          ],
        ),
      ),
    );
  }
}