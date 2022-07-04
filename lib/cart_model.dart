class Cart{
 late final int? pid;
 late final String? pname;
 late final  int? initialprice;
 late final  int? quantity;
 late final int? price;
 late final String? pimg;

  Cart({
    required this.pid, required this.pname, required this.initialprice, required this.quantity, required this.price,
      this.pimg
  });

  Cart.fromMap(Map<dynamic,dynamic>res)
  :pid = res['pid'],
  pname =res['pname'],
  initialprice =res['initialprice'],
  quantity= res['quantity'],
  price = res['price'],
  pimg = res['pimg'];

  Map<String,Object?> toMap(){
    return{
      'pid':pid,
      'pname':pname,
      'initialprice':initialprice,
      'quantity':quantity,
      'price':price,
      'pimg':pimg,

    };
  }


}