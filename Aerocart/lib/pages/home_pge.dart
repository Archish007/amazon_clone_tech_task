import 'package:amazon_clone/utils/carousel.dart';
import 'package:amazon_clone/utils/categories.dart';
import 'package:amazon_clone/cloud_firestore_methods/cloud_firestore.dart';
import 'package:amazon_clone/pages/search_screen.dart';
import 'package:amazon_clone/utils/loading_widget.dart';
import 'package:amazon_clone/utils/products_showcase.dart';
import 'package:amazon_clone/utils/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double offset = 0;
  ScrollController scrollController = ScrollController();
  final search = TextEditingController();
  List<Widget>? product = [];
  List<Widget>? images = [];
  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose;
    super.dispose();
  }

  void getData() async {
    List<Widget>? temp = await CloudFirestoreClass().getProducts();
    List<Widget>? temp1 = await CloudFirestoreClass().getImages();
    setState(() {
      product = temp;
      images = temp1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 75),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 168, 202, 127), Color.fromARGB(255, 37, 46, 42)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Image.asset(
                    'lib/images/amazon.png',
                    height: 75,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                    },
                    child: Container(
                      width: width * 0.655,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.blueGrey, width: 2),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.search,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
        backgroundColor: Colors.blueGrey[50],
        body: product != null
            ? Stack(children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(children: [
                    const SizedBox(
                      height: 40,
                      width: double.infinity,
                    ),
                    const CategoriesBar(),
                    ImageCarousel(myitems: images!),
                    const Text(
                      "Recomended Items",
                      style: TextStyle(fontSize: 16),
                    ),
                    ProductsShowcase(children: product!),
                    const SizedBox(
                      height: 80,
                    ),
                  ]),
                ),
                UserDetailsBar(
                  offset: offset,
                )
              ])
            : const LoadingWidget());
  }
}
