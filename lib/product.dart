import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(new Product());
class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'list',
      theme: new ThemeData(
        primaryColorDark: Colors.black26,
      ),
      home: new MyHomePage(title: 'product',),
    );

  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Products>> _getProduct() async {

    var data = await http.get(Uri.parse('http://192.168.0.103:8000/api/allpro'));

    var jsonData = json.decode(data.body);

    List<Products> users = [];

    for(var u in jsonData){

      Products pro = Products(u["pid"], u["pname"], u["pimg"], u["packsize"], u["bid"],u["cid"],u["price"]);

      users.add(pro);

    }

    print(users.length);

    return users;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getProduct(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data == null){
              return Container(
                  child: Center(
                      child: Text("Loading...")
                  )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data[index].pimg
                        ),
                      ),
                      title: Text(snapshot.data[index].pname),
                      subtitle: Text(snapshot.data[index].packsize),
                      onTap: (){




                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}


class Products {
  //data Type
  int? pid;
  String? pname;
  String? pimg;
  String? packsize;
  int? bid;
  int? cid;
  String? price;

  Products(
    this.pid,
    this.pname,
    this.pimg,
    this.packsize,
    this.bid,
    this.cid,
    this.price
  );
}
