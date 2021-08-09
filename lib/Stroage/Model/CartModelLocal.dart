class CartMedelLocal{
  //attributes = fields in table
  int _id=0;
  String _name="";
  String _img="";
  String _category="";
  double _price=0;
  int _quantity=0;
  CartMedelLocal(dynamic obj){
    _id = obj['id'];
    _name = obj["name"];
    _img=obj["img"];
    _price = obj["price"];
    _quantity = obj["quantity"];
    _category=obj["category"];
  }
  CartMedelLocal.fromMap(Map<String,dynamic> data){
    _id = data['id'];
    _name = data['name'];
    _img = data['img'];
    _category=data["category"];
    _price = data['price'];
    _quantity = data['quantity'];
  }
  Map<String, dynamic> toMap() => {'id' : _id,'name' : _name,'img' : _img,"category":_category,'price' : _price,'quantity' : _quantity,};
  int get id => _id;
  String get name => _name;
  String get img => _img;
  String get category=>_category;
  double get price => _price;
  int get quantity => _quantity;
}