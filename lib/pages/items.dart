import 'package:flutter/material.dart';
import 'package:kirana/models/Item.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/widgets/GotoCartIcon.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/menuitem_widget.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final name = 'Items';
  List<Item> items;
  Shop shop;

  void setShop(String shopId)async{
    var shopProvider = Provider.of<Shops>(context, listen: false);
    Shop tShop = await shopProvider.getShopByuserId(shopId);
    setState(() {
      shop = tShop;
    });
  } 
  @override
  Widget build(BuildContext context) {
    return Consumer<Shops>(builder: (context, catalog, child) {
      return StreamBuilder<List<Item>>(
          stream: catalog.items.addFromFireStore(catalog.selectedshopid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {

              List<MenuItem> list =[];
              for (var item in (snapshot.data)) list.add(MenuItem(item));
              setShop(catalog.selectedshopid);
              return Scaffold(
                  drawer: DrawerPage(),
                  body: CustomScrollView(
                  slivers: <Widget>[
              SliverAppBar(
                actions: <Widget>[Search(snapshot.data), CartIcon()],
                expandedHeight: 220.0,
                floating: true,
                pinned: true,
                snap: true,
                elevation: 50,
                backgroundColor: Colors.blue,
                flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.fromLTRB(55, 10, 0, 10),
                    title: Text('${shop.name}\n\t\t\t\t\t\t\t\t\t\t${shop.address}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      shop.imageurl,
                      fit: BoxFit.cover,
                    )
                ),
              ),
              new SliverList(
                  delegate: new SliverChildListDelegate(list)
              ),
            ],
          ),
        
      );
    }
            }
          );
    });
  }
}

class Search extends StatelessWidget {
  final List<Item> items;
  Search(this.items);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: Itemssearch(items));
        });
  }
}

class Itemssearch extends SearchDelegate<Item> {
  List<Item> items;
  Itemssearch(this.items);
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
  String get searchFieldLabel => "Search items";

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
    List<Widget> suggestions = items
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.description.toLowerCase().contains(query.toLowerCase()))
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
                child: Text(e.description),
              ),
              onTap: () {
                query = e.name;
                showResults(context);
              },
            ))
        .toList();
    return ListView(children: suggestions);
  }
}
