import 'package:flutter/material.dart';
import 'main.dart';
import 'coffee_list.dart';

class DrawerNavigation extends StatefulWidget {
  final String title;
  final Widget widget;
  const DrawerNavigation({super.key, required this.title, required this.widget});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF041C36),
        title: Text(widget.title,
            style: const TextStyle(color: Colors.white),
      ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
          child: widget.widget
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF041C36),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Home', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  MyHomePage(title: widget.title),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Products', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CoffeeList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
