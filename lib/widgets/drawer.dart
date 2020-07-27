import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kirana/models/location.dart';
import 'package:kirana/models/user.dart';
import 'package:provider/provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class DrawerPage extends StatelessWidget {
  @override
  Widget build(context) {
    return Consumer<User>(builder: (context, user, child) {
      return Container(
        width: 3 * MediaQuery.of(context).size.width / 5,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.white60),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Hello ${user.name}",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text(user.email),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Text(
                  "Home",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                title: Text(
                  "Cart",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              ListTile(
                title: Text(
                  "Shops Nearby",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/shops');
                },
              ),
              ListTile(
                title: Text(
                  "Orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/orders');
                },
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              user.role == 'owner'
                  ? ListTile(
                      title: Text(
                        "Edit your shop",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/register');
                      },
                    )
                  : ListTile(
                      title: Text(
                        "Register your shop",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
              user.role == 'owner'
                  ? ListTile(
                      title: Text(
                        "Edit Items",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/edit');
                      },
                    )
                  : Container(),
              ExpansionTile(
                trailing: Icon(Icons.settings),
                title: Text("Location Settings",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                children: <Widget>[
                  Consumer<LocationModel>(builder: (context, location, child) {
                    return SliderContainer();
                  }),
                  RaisedButton(
                  child: Text("Update location"),
                  color: Colors.amber,
                  onPressed: () {
                    Provider.of<LocationModel>(context,listen: false).getposition();
                    Navigator.pop(context);
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Location updated")));
                  },
                )
                ],
              ),
              ListTile(
                title: Text(
                  "Sign out",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  user.signout(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SliderContainer extends StatefulWidget {
  @override
  _SliderContainerState createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationModel>(
      builder: (context, location,child) {
        return Column(
          children: <Widget>[
            Text("distance:- ${location.radius.floor()}km"),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Slider(
                  label: 'Search radius',
                  value: location.radius == null ? 5 : location.radius,
                  onChanged: (value) {
                    location.setradius(value);
                  },
                  min: 1,
                  max: location.radius<100?100:location.radius+100,
                )),
          ],
        );
      }
    );
  }
}






