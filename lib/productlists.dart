import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class Productlists extends StatefulWidget {
  const Productlists({Key? key}) : super(key: key);

  @override
  State<Productlists> createState() => _ProductlistsState();
}

class _ProductlistsState extends State<Productlists> {


  List<String> pname=['Foundation','Lipstick','Eyeliner','kajal','Eyeshadow Palette'];
  List<int> prounit=[1,1,1,1,1 ];
  List<int> proprice=[500,700,900,1200,2000];
  List<String>pimg=[

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductList'),
        centerTitle: true,
        actions: [
          Center(
            child: Badge(
              badgeContent: Text('0',style: TextStyle(color: Colors.white),),
              animationDuration: Duration(milliseconds: 300),
              child: Icon(Icons.shopping_bag_outlined) ,
            ),
          ),

          SizedBox(width: 20,)
        ],
      ),

      body:Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount:10 ,
              itemBuilder:(context,index){
            return Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(index.toString())
                    ],
                  )
                ],
              ),
            );
    })
          )],
      )
    );
  }
}
