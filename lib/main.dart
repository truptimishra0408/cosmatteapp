
import 'package:cart/cart_provider.dart';
import 'package:cart/cartdetails.dart';
import 'package:cart/detailspage.dart';
import 'package:cart/front.dart';
import 'package:cart/login.dart';
import 'package:cart/product.dart';
import 'package:cart/productlist.dart';
import 'package:cart/productlists.dart';
import 'package:cart/registration.dart';
import 'package:cart/signup.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';









void main() => runApp(MaterialApp(
  initialRoute: '/productlist',
  routes: {

    '/front':(context)=>Front(),
    '/registration':(context)=>Registration(),
    '/login':(context)=>Login(),
    '/signup':(context)=>Signup(),
    '/productlist':(context)=>Productlist(),
    '/product':(context)=>Product(),
    '/detailspage':(context)=>DetailsPage(productid:"0"),
    '/cartdetails':(context)=>Cartdetails(),
    '/productlists':(context)=>Productlists(),







  },
));



class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

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
        home: Productlists(),
      ),
    );
  }
}
