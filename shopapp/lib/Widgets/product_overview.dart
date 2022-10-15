// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/product_controller.dart';
import 'package:shopapp/Screens/product_details.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Models/products.dart';

class ProductOverviewWidget extends StatelessWidget {
  const ProductOverviewWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    //height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetails.routName, arguments: product);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.transparent.withOpacity(0.0),
                      Colors.black,
                    ],
                    stops: const [
                      0.0,
                      1.0
                    ])),
          ),
        ),
        Positioned(
          right: 8,
          top: 2,
          left: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(label: Text('-${(((product.oldPrice - product.price)/product.oldPrice)*100).toStringAsFixed(1)}%'),
              labelStyle: const TextStyle(color: Colors.red,),
              ),
              IconButton(
                  onPressed: () {
                    context.read<ProductController>().toggleFavorite(product);
                  },
                  icon: Icon(
                    product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    size: 40,
                    color: product.isFavorite ? Colors.red : Colors.white,
                  )),
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 2),
                child: Text(
                  product.title,
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Ugx ${product.oldPrice}',
                  style:const  TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Ugx ${product.price}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        )
      ],
    );
  }
}
