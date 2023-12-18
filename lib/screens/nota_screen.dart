import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/src/material/data_table.dart';

class NotaPage extends StatefulWidget {
  const NotaPage({Key? key}) : super(key: key);

  @override
  State<NotaPage> createState() => _NotaPage();
}
class _NotaPage extends State<NotaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: Text('Nota'),
      ),
      body: MyStatelessWidget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatefulWidget {
  MyStatelessWidget({Key?key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  List<DataRow> datarow=[];
  _MyStatelessWidgetState(){
    getdata();
  }
  void getdata() async {
    final String url = 'https://semai.000webhostapp.com/public/api/keranjang?user_id=1';
    var response = await http.get(Uri.parse(url));
    final List data = json.decode(response.body)['data']['data'];
    final total = json.decode(response.body)['data']['total'];
    print(data);
    setState(() {
      for(int i=0;i<data.length;i++){
        datarow.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(data[i]['semai']['name'])),
            DataCell(Text(data[i]['jumlah'].toString())),
            DataCell(Text(data[i]['semai']['price'].toString())),
          ],
        ));
      }
      datarow.add(
          DataRow(
            cells: <DataCell>[
              DataCell(Text('total')),
              DataCell(Text('')),
              DataCell(Text(total.toString())),
            ],
          ),
      );

    });
  }
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Produk',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Quantity',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Harga',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: datarow,
    );
  }
}