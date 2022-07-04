

import 'dart:convert';

import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';


class DetailsPage extends StatefulWidget {
  final String? productid;
  const DetailsPage({Key? key, required this.productid}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

int pid=0;
String pname="uu";
String pimg="njj";
String packsizes="4ml";
int bid=1;
int cid=2;
int price=2000;


Future<List<Map<String, dynamic>>> fetchProductInfo(String? productid) async {
  //String pid= await SharedPreferencesHelper.getUser();
  //print(pid);
  final response = await http.post(
    Uri.parse("http://192.168.0.102:8000/api/productid"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'pid':productid as String

    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return List<Map<String, dynamic>>.from(json.decode(response.body)['indus']);
    //return UserInfo.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to create album.');
  }
}


Future<void> plson(String? productid) async {
  fetchProductInfo(productid).then((value) =>
  {


    for(var vax in value) {

      pid = vax.values.elementAt(0),
      pname = vax.values.elementAt(1),
      pimg = vax.values.elementAt(2),
      packsizes = vax.values.elementAt(3),
      bid = vax.values.elementAt(4),
      cid = vax.values.elementAt(5),
      price = vax.values.elementAt(6),


    }
  });
}
class ProductInfo {
  final int pid;
  final String pname;
  final String pimg;
  final String packsize;
  final int bid;
  final int cid;
  final int price;

  ProductInfo({required this.pid,required this.pname,required this.pimg,required this.packsize,required this.bid,required this.cid,  required this.price});
  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      pid: json['pid'],
      pname: json['pname'],
      pimg: json['pimg'],
      packsize: json['packsize'],
      bid: json['bid'],
      cid: json['cid'],
      price: json['price'],
    );
  }
}






class _DetailsPageState extends State<DetailsPage> {

  int proid = 0;
  String pronme = "pnme";
  String proimg = "hjj";
  String packsize = "4ml";
  int pbid = 4;
  int pcid = 3;
  int proprice = 1230;
  bool isloading = true;

  @override
  void initState() {
    super.initState();

    //fetchProductInfo(widget.productid);
    plson(widget.productid);
    setState(() {

      proid = pid;
      pronme = pname;
      proimg = pimg;
      packsize = packsizes;
      pbid = bid;
      pcid = cid;
      proprice = price;
      isloading = false;
    });

    setState(() {
      //isloading = false;
    });
  }

  void executePostBuild() {
    setState(() {
      isloading = false;
      proid = pid;
      pronme = pname;
      proimg = pimg;
      packsize = packsizes;
      pbid = bid;
      pcid = cid;
      proprice = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    executePostBuild();
    return Scaffold(
      appBar: AppBar(title: Text(pronme),
      backgroundColor: Colors.red),
    body: (isloading==true) ?
    CircularProgressIndicator() : Card(


      child: Column(

        children: [

        Image.network(proimg,
          width:double.infinity ,
          fit: BoxFit.fitWidth,),
          Container(

            child:  Container(
             margin:  EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  pronme,style: TextStyle(fontSize: 22,color: Colors.red,fontWeight:FontWeight.bold),)),


          ),
          Container(
              child: Text('PACKSIZE:' +
                packsize,style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight:FontWeight.bold),)),
          Container(
              child: Text('BRANDID:' +
                pbid.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight:FontWeight.bold),)),
          Container(
              child: Text('CATEGORYID:' +
                pcid.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight:FontWeight.bold),)),
          Container(
              child: Text('PRICE: '+
                proprice.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight:FontWeight.bold),)),

          ElevatedButton(
            child: const Text('Add To Cart'),
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange
            ),
          )
        ],
      ),
    ),


    );

  }


}
