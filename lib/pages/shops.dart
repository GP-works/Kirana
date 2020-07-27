import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kirana/models/location.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/widgets/GotoCartIcon.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/shop_widget.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/shops.dart';

class ShopsPage extends StatefulWidget {
  @override
  _ShopsPageState createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  final name = 'Shops';
  Shops shops;
  double radius = 5.0;
  double max = 50;
  Position _currentLocation;
  @override
  Widget build(BuildContext context) {
    return Consumer<Shops>(builder: (context, shops, child) {
      return Consumer<LocationModel>(builder: (context, location, child) {
        _currentLocation = location.position;
        radius = location.radius == null ? 5 : location.radius;
        shops = shops;
        return _currentLocation != null
            ? StreamBuilder<List<Shop>>(
                stream: shops.fromf(
                    latitude: _currentLocation.latitude,
                    longitude: _currentLocation.longitude,
                    radius: radius),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Scaffold(
                        body: Center(
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return Scaffold(
                      drawer: DrawerPage(),
                      body: ListView(children: [
                        for (var shop in snapshot.data) ShopPage(shop),
                      ]),
                      appBar: AppBar(
                        title: Text("Shops"),
                        actions: <Widget>[Search(shops.shops), CartIcon()],
                      ),
                    );
                  }
                })
            : Scaffold(
                appBar: AppBar(),
                drawer: DrawerPage(),
                body: ListView(children: [
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      "Location settings were not updated before please set the radius and press fetch you can change this location later in settings",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "radius:-${radius.floor()} km",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Slider(
                        label: 'Search radius',
                        value: radius == null ? 5 : radius,
                        onChanged: (value) {
                          location.setradius(radius);
                          setState(() {
                            radius = value;
                            if (radius > 30) {
                              max = radius + 10;
                            }
                          });
                        },
                        min: 1,
                        max: max,
                      ))
                ]),
                floatingActionButton: RaisedButton(
                  child: Text("Fetch shops"),
                  color: Colors.amber,
                  onPressed: () {
                    location.getposition();
                  },
                ));
      });
    });
  }
}

class Search extends StatelessWidget {
  final List<Shop> shops;
  Search(this.shops);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: Shopssearch(shops));
        });
  }
}

class Shopssearch extends SearchDelegate<Shop> {
  List<Shop> shops;
  Shopssearch(this.shops);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: Colors.white,
        primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        primaryColorBrightness: Brightness.light,
        textTheme: theme.textTheme.copyWith(
            headline6: theme.textTheme.headline6
                .copyWith(fontSize: 18, fontWeight: FontWeight.normal)));
  }

  @override
  String get searchFieldLabel => "Search nearby shops";

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text("hello"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Widget> suggestions = shops
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.address.toLowerCase().contains(query.toLowerCase()))
        .map((e) => ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e.name.toUpperCase(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(e.address),
              ),
              onTap: () {
                query = e.name;
                Shops shopProvider = Provider.of<Shops>(context, listen: false);
                shopProvider.setItems(e.userid);
                Navigator.pushReplacementNamed(context, '/items');
              },
            ))
        .toList();
    return ListView(children: suggestions);
  }
}
