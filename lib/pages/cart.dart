import 'package:flutter/material.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/widgets/cartitem_widget.dart';
import 'package:kirana/pages/orders.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:kirana/database/cart.dart';
import 'package:kirana/models/shops.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  double currentPrice;
  String currentShop;

  void updatePrice(CartModel cart) async{
    double currentprice = await cart.getTotalprice(currentShop);
    setState(() {
      currentPrice = currentprice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child:
        Consumer<CartModel>(builder: (context, cart, child) {
        return StreamBuilder<List<Orderitem>>(
          stream: cart.fromf(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                  drawer: DrawerPage(),
                  appBar: AppBar(title: Text("Cart"), actions: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            cart.deleteAll();
                          },
                          child: Icon(
                            Icons.delete,
                            size: 26.0,
                            color: Colors.red,
                          ),
                        ))
                  ]),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ));
            } 
            else{
                  //var shopProvider = Provider.of<Shops>(context, listen: false);
                  updatePrice(cart);
                  List<CartItem> list = [];
                  for (var item in (snapshot.data) )
                     {
                       if(item.shop == currentShop )
                         list.add(CartItem(item)); 
                     }
                  cart.updateShops();
                  return Scaffold(
                    drawer: DrawerPage(),
                    appBar: AppBar(title: Text("APP_NAME"), actions: <Widget>[
                     Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                        onTap: () {
                          cart.deleteAll();
                        },
                        child: Icon(
                          Icons.delete,
                          size: 26.0,
                          color: Colors.red,
                        ),
                          ))
                                ]),
                    body: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 50,
                              width: double.infinity,
                              color: Colors.black,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                  child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                  for (int i = 0; i < cart.shops.length; i++)
                                    Container(
                                      width: 58,
                                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                      child: button(cart.shops[i])),
                                   ],),),),
                          Container(
                              child: ListView(
                                children: list,
                              ),
                          )
                          ],
                        ),
                        ),
                    bottomNavigationBar: BottomAppBar(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Total price : ',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "$currentPrice",
                              style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                              fontSize: 18),
                            ),
                            FlatButton(
                            onPressed: () {
                                cart.create_order(currentShop);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrdersPage()));
                          },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              Text(
                                "checkout",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                               ),
                              ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.lightBlueAccent,
                            )],
                        ),)], ),
                      ),
                  );
            }
          },
        );
      })); 
    }

    Widget button(String shopId) => Button(
        key: ValueKey('button$shopId'),
        isSelected: this.currentShop == shopId,
        shopId: shopId,
        onPressed: () {
          showExample(
            shopId
          );
        },
      );

  void showExample(String shopId) => setState(() {
        this.currentShop = shopId;
      });
}

//////////////////////////////////////////////////

class Button extends StatelessWidget {
  final Key key;
  final bool isSelected;
  final String shopId;
  final VoidCallback onPressed;

  Button({
    this.key,
    this.isSelected,
    this.shopId,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Consumer<Shops>(builder: (context, shops, child) {

    return MaterialButton(
        color: isSelected ? Colors.grey : Colors.grey[800],
        child: Text(shops.getShopById(shopId).name, style: TextStyle(color: Colors.white)),
        onPressed: () {
          Scrollable.ensureVisible(
            context,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
            alignment: 0.5,
          );
          onPressed();
        });

        });
  }
}
