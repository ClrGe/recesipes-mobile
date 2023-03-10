import 'package:flutter/material.dart';
import '../providers/AuthProvider.dart';
import '../pages/categories.dart';
import '../pages/menu.dart';
import '../pages/recipes.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = [Menu(), Recipes(), Categories()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenue sur reCESIpes !',
      home: Scaffold(
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Toutes les recettes'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box), label: 'Recette au hasard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.logout), label: 'Déconnexion')
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  Future<void> onItemTapped(int index) async {
    if (index == 3) {
      final AuthProvider provider =
          Provider.of<AuthProvider>(context, listen: false);

      await provider.logOut();
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }
}
