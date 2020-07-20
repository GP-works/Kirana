import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kirana/models/user.dart';
import 'package:provider/provider.dart';
FirebaseAuth _auth=FirebaseAuth.instance;
class DrawerPage extends StatelessWidget{
  @override
  Widget build(context){
    final user=Provider.of<User>(context,listen:false);
    return Container(
      width: 3*MediaQuery.of(context).size.width/5,
      child: Drawer(

        child: ListView(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white60),
            child: ListTile(
              title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Hello ${user.name}",style: TextStyle(fontSize: 24),),
            ),subtitle: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(user.email),
            ),
            ),
          ),
          Divider(thickness: 1,color: Colors.grey,),
          ListTile(
            title: Text("Home",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: Text("Cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cart');
            },
          ),

          ListTile(
            title: Text("Shops Nearby",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/shops');
            },
          ),
          ListTile(
            title: Text("Orders",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/orders');
            },
          ),
          Divider(thickness: 0.5,color: Colors.grey,),
          ListTile(
            title: Text("Register your shop",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/register');
            },
          ),
          ListTile(
            title: Text("Edit Items",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/edit');
            },
          ),
          ListTile(
            title: Text("Sign out",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            onTap: (){
              user.signout();
            },
          ),


        ],),
      ),
    );

  }
}