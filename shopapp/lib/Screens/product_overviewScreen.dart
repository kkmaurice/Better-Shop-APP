// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/product_controller.dart';
import 'package:shopapp/Widgets/app_drawer.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../Widgets/product_overview.dart';

class ProductOverView extends StatefulWidget {
  const ProductOverView({Key? key}) : super(key: key);

  static const routeName = '/home_screen';

  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  TextEditingController _controller = TextEditingController();
  int _selectedIndex = 0;
  List<Widget> _chips = [
    const Text('All'),
    const Text('Clothes'),
    const Text('Electronics'),
    const Text('Fruits'),
    const Text('Shoes'),
    const Text('Furniture'),
    const Text('Others'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductController>().products;
    final searchingProduct = context.watch<ProductController>().searchResult;
    final categoryProducts = context.watch<ProductController>().getProductsByCategory(_chips[_selectedIndex].toString());
    return Scaffold(
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: context.read<ProductController>().fetchProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.error != null) {
                  return const Text('An error occurred');
                } else {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          expandedHeight: 100,
                          floating: true,
                          //pinned: true,
                          title: Text(
                            'Welcome Shopping',
                            style: GoogleFonts.tangerine(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          actions: const [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1593104547489-5cfb3839a3b5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjV8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                          elevation: 0,
                          iconTheme: const IconThemeData(color: Colors.black87),
                          backgroundColor: Colors.transparent,
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(0.0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 3),
                              child: TextField(
                                controller: _controller,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  hintText: 'Search Product',
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 18),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _controller.text = '';
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 25,
                                        color: Colors.red,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 15, 10, 15),
                                ),
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  context
                                      .read<ProductController>()
                                      .runFilter(value);
                                },
                              ),
                            ),
                          )),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('Categories',
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _chips.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _onItemTapped(index);
                                  // context
                                  //     .read<ProductController>()
                                  //     .getProductsByCategory(_chips[index].toString());
                                  print('index is $index');
                                },
                                child: Chip(
                                  label: _chips[index],
                                  labelStyle: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                      ),
                                  backgroundColor: _selectedIndex == index
                                      ? Colors.grey
                                      : Colors.black,
                                  ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () => context
                                      .read<ProductController>()
                                      .fetchProducts(),
                                  child: StaggeredGridView.countBuilder(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      staggeredTileBuilder: (index) {
                                        return StaggeredTile.count(
                                            1, index.isEven ? 1.2 : 1.8);
                                      },
                                      itemCount: _controller.text.isEmpty? product.length : searchingProduct.length,
                                      itemBuilder: (context, index) {
                                        return ProductOverviewWidget(
                                            product: _controller.text.isEmpty? product[index] : searchingProduct[index]);
                                      }),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]))
                    ],
                  );
                }
              }
            }));
  }
}
