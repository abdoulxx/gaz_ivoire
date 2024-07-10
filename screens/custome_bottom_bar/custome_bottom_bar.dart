import 'package:flutter/material.dart';
import 'package:gazivoire/screens/commande/commande.dart';
import 'package:gazivoire/screens/profile/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../home/home.dart';


class CustmBottonBar extends StatefulWidget {
  const CustmBottonBar({final Key? key, })
      : super(key: key);

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<CustmBottonBar> {
  PersistentTabController _controller=PersistentTabController();
  bool _hideNavBar= false;


  List<Widget> _buildScreens() => [
     const Home(),
     CommandePage(),
    const Profile(),

  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        inactiveColorSecondary: Colors.purple),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_cart),
      title: "Commande",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white70,
    ),

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: "Profile",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white70,

    ),

  ];

  @override
  Widget build(final BuildContext context) => Scaffold(

    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      bottomScreenMargin: 0,


      backgroundColor: Colors.blue.shade900,
      hideNavigationBar: _hideNavBar,
      decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle
          .style1, // Choose the nav bar style with this property
    ),
  );
}
