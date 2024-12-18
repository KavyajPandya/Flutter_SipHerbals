import 'package:flutter/material.dart';
import 'coffee_detail.dart';
import 'coffee.dart';
import 'drawer_navigation.dart';

class CoffeeList extends StatefulWidget {
  const CoffeeList({super.key});

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final List<Coffee> coffeeList = [
    Coffee('Signature Roast Faux Joe Coffee Alternative (Loose Leaf)', 'img1.jpg', 2.99, 'A nutty, earthy blend of herbs reminiscent of a gentle cup o’Joe - not burnt, never acidic, with just the right tinge of bitterness.'),
    Coffee('"Cinnamon Roll" Faux Joe Coffee Alternative (Loose Leaf)', 'img2.jpg', 3.49, 'Stacked with the aromas of an ooey-gooey cinnamon roll, our Cinnamon Roll Faux Joe brings you the bakery-fresh taste you love in every little sip.'),
    Coffee('"Salted Maple Blondie" Faux Joe Coffee Alternative (Loose Leaf)', 'img3.jpg', 3.49, 'A slightly sweet blend of maple, date, vanilla herbal brew.A slightly sweet blend of maple, date, vanilla herbal brew.'),
    Coffee('"Dirty Chai" Faux Joe Coffee Substitute (Loose Leaf)', 'img4.png', 3.49, 'A bold herbal fusion of spiced chai and nutty coffee-esque notes. A slightly sweet blend of maple, date, vanilla herbal brew.'),
    Coffee('"Royal Mocha" Faux Joe Coffee Alternative (Loose Leaf)', 'img5.jpg', 3.49, 'A decadent herbal blend of dark chocolate with notes of vanilla. A slightly sweet blend of maple, date, vanilla herbal brew.'),
    Coffee('"Peppermint Mocha" Faux Joe Coffee Alternative (Loose Leaf)', 'img6.jpg', 3.49, 'A decadent herbal blend of dark chocolate and refreshing peppermint. A slightly sweet blend of maple, date, vanilla herbal brew.'),
    Coffee('"The Favorites" Faux Joe Sample Pack (Loose Leaf)', 'img7.png', 3.49, 'Indulge in the captivating flavors of our Signature Roast, Salted Maple Blondie, and Royal Mocha, all carefully crafted in mini-sized portions for your convenience.'),
    Coffee('Dirty Chai Coffee Alternative Tea Bags', 'img8.png', 3.49, 'A bold herbal fusion of spiced chai and nutty coffee-esque notes.A slightly sweet blend of maple, date, vanilla herbal brew.'),
    Coffee('As Seen on Shark Tank Sample Bundle (Loose Leaf)', 'img9.jpeg', 3.49, 'A bold herbal fusion of spiced chai and nutty coffee-esque notes.A slightly sweet blend of maple, date, vanilla herbal brew.'),
    Coffee('“Irresistible Flavors” Faux Joe Sample Pack (Loose Leaf)', 'img1.jpg', 3.49, 'A decadent herbal blend of dark chocolate and refreshing peppermint.A slightly sweet blend of maple, date, vanilla herbal brew.'),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerNavigation(
      title: 'Coffee List',
      widget: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0x9AD5F5FF),
              child: ListView.builder(
                itemCount: coffeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoffeeDetail(coffee: coffeeList[index]),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(9),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'coffee-image-${coffeeList[index].name}',
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image(
                                    height: 108,
                                    width: 108,
                                    image: AssetImage("assets/images/${coffeeList[index].image}"),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 27),
                            Expanded(
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coffeeList[index].name,
                                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\$${coffeeList[index].price.toString()}',
                                        style: const TextStyle(fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
