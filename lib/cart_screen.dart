import 'package:badges/badges.dart';
import 'package:cart/cart_model.dart';
import 'package:cart/cart_provider.dart';
import 'package:cart/db_helper.dart';
import 'package:cart/detailspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper=DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        centerTitle: true,
        actions: [
          Center(
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

          SizedBox(width: 20,)
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: cart.getData(),
              builder:( context, AsyncSnapshot<List<Cart>> snapshot){
               if(snapshot.hasData){

              return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsPage(productid: snapshot.data![index].pid.toString())));
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
                                      NetworkImage(snapshot.data![index].pimg.toString()),
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data![index].pname.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    dbHelper!.delete(snapshot.data![index].pid!);
                                                    cart.removeCounter();
                                                    cart.removeTotalPrice(double.parse(snapshot.data![index].price.toString()));
                                                  },
                                                    child: Icon(Icons.delete)),
                                              ],
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(left: 8, right: 8),
                                              child: Text(snapshot.data![index].price.toString(),style: TextStyle(fontSize: 15,color: Colors.deepOrange),),
                                            ),

                                            Padding(

                                              padding: EdgeInsets.only(left: 8, right: 8),
                                              child: Text(snapshot.data![index].initialprice.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(

                                              padding: EdgeInsets.only(left: 8, right: 8),
                                              child: Text(snapshot.data![index].quantity.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold),),

                                            ),
                                            Padding(

                                              padding: EdgeInsets.only(left: 8, right: 8),
                                              child: Text(snapshot.data![index].pid.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold),),
                                            ),

                                            Align(

                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: (){
                                                                                                  },


                                                child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green
                                                    ),
                                                    child: Row(

                                                      children: [
                                                        Icon(Icons.add),
                                                        Text(snapshot.data![index].quantity.toString(),style: TextStyle(color:Colors.white),

                                                       ),
                                                      ],
                                                    )),
                                              ),
                                            )

                                          ],
                                        ),

                                      ))
                                ],
                              ),

                            ),

                          ),
                        );
                      }),);
               }
              return  Text('');

              }),
          Consumer<CartProvider>(builder: (context,value,child){
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2)=="0.00" ? false:true,
              child: Column(
                
                  children: [
                  ReusableWidget(title: 'Sub Total', value: r'Rs.'+value.getTotalPrice().toStringAsFixed(2),),
              ],
              ),
            );
          })
        ],
      ),
    );
  }
}
class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString(), style: Theme.of(context).textTheme.subtitle2,),

        ],
      ),
    );
  }
}




