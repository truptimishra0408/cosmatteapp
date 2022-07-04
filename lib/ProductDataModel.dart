class ProductDataModel {
  //data Type
  int? pid;
  String? pname;
  String? pimg;
  String? packsize;
  int? bid;
  int? cid;
  String? price;

  ProductDataModel(
      {
        this.pid,
        this.pname,
        this.pimg,
        this.packsize,
        this.bid,
        this.cid,
        this.price
}
);
  ProductDataModel.fromJson(Map<String,dynamic> json)
  {
  pid = json['pid'];
  pname =json['pname'];
  pimg = json['pimg'];
  packsize = json['packsize'];
  bid = json['bid'];
  cid = json['cid'];
  price = json['price'];
 }
}



