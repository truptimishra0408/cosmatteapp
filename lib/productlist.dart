import 'dart:convert';



import 'package:badges/badges.dart';
import 'package:cart/ProductDataModel.dart';
import 'package:cart/cart_model.dart';
import 'package:cart/cart_provider.dart';
import 'package:cart/cart_screen.dart';
import 'package:cart/db_helper.dart';
import 'package:cart/detailspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

import 'package:provider/provider.dart';




class Productlist extends StatelessWidget {
  const Productlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider( create: (context) =>CartProvider(),),
    ],
      child: MaterialApp(
        title:'add to cart' ,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
DBHelper? dbHelper=DBHelper();
  @override
  Widget build(BuildContext context) {
final cart=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductList'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CartScreen()));
            },
            child: Center(
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context,value,child){
                      return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white));
                  },
                    ),
                animationDuration: Duration(milliseconds: 300),
                child: Icon(Icons.shopping_bag_outlined) ,
              ),
            ),
          ),

          SizedBox(width: 20,)
        ],
      ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: ReadJsonData(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var items = data.data as List<ProductDataModel>;
                    return ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage(productid: items[index].pid.toString())));
                            },
                              child: Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Image(
                                          image:
                                          NetworkImage(items[index].pimg.toString()),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8, right: 8),
                                                  child: Text(
                                                    items[index].pid.toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8, right: 8),
                                                  child: Text(items[index].pname.toString(),style: TextStyle(fontSize: 15,color: Colors.deepOrange),),
                                                ),

                                                Padding(

                                                  padding: EdgeInsets.only(left: 8, right: 8),
                                                  child: Text(items[index].packsize.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(

                                                  padding: EdgeInsets.only(left: 8, right: 8),
                                                  child: Text(items[index].bid.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.bold),),

                                                ),
                                                Padding(

                                                  padding: EdgeInsets.only(left: 8, right: 8),
                                                  child: Text(items[index].cid.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.bold),),
                                                ), Padding(

                                                  padding: EdgeInsets.only(left: 8, right: 8),
                                                  child: Text(items[index].price.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.bold),),
                                                ),

                                                Align(

                                                  alignment: Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: (){
                                                      dbHelper!.insert(Cart(
                                                          pid:  items[index].pid,
                                                          pname: items[index].pname,
                                                          initialprice:int.parse(items[index].price.toString()),
                                                          price: int.parse(items[index].price.toString()),
                                                          quantity: 1,
                                                          pimg: items[index].pimg)
                                                      ).then((value){
                                                        print('product is added to cart');
                                                        cart.addTotalPrice(double.parse(items[index].price.toString()));
                                                        print(items[index].pid);
                                                        cart.addCounter();
                                                      }).onError((error, stackTrace){
                                                        print(error.toString());
                                                      }

                                                      );





                                                    },


                                                    child: Container(
                                                      height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                          color: Colors.green
                                                        ),
                                                        child: Text('add to cart',style: TextStyle(color:Colors.white),)),
                                                  ),
                                                )

                                              ],
                                            ),

                                          )),



                                    ],
                                  ),

                                ),

                              ),
                            );

                          },

                      );





                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      
      
      
    );
  }

    
  

  Future<List<ProductDataModel>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ProductDataModel.fromJson(e)).toList();
  }
}




