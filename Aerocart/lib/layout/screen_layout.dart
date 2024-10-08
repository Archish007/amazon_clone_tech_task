import 'package:amazon_clone/pages/cart_page.dart';
import 'package:amazon_clone/pages/home_pge.dart';
import 'package:amazon_clone/pages/user_page.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int currPage = 0;
  final List<Widget> tablist = [
    const HomePage(),
    const CartPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    return Scaffold(
        body: Stack(children: [
      tablist.elementAt(currPage),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
                selectedItemColor: const Color.fromARGB(255, 122, 207, 25),
                unselectedItemColor: Colors.black,
                backgroundColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: currPage,
                onTap: (int page) {
                  setState(() {
                    currPage = page;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: "Cart",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: "User",
                  ),
                ]),
          ),
        ),
      ),
    ]));
  }
}
