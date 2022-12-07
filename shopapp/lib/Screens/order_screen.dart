import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/orders.dart';
import 'package:shopapp/Screens/product_overviewScreen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = context.watch<OrderProvider>();
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(ProductOverView.routeName);
              }),
          centerTitle: true,
          title: const Text(
            'Orders',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: context.read<OrderProvider>().fetchOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: order.orders.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            child: ExpansionTile(
                              title: Text(
                                'Amount: Ugx. ${order.orders[index].amount}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                formatDate(order.orders[index].dateTime, [
                                  MM,
                                  ' ',
                                  d,
                                  ', ',
                                  yyyy,
                                  ' ',
                                  HH,
                                  ':',
                                  nn,
                                  ':',
                                  ss
                                ]),
                                style: const TextStyle(fontSize: 18),
                              ),
                              children: order.orders[index].ordered
                                  .map((item) => ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            item.imageUrl,
                                          ),
                                        ),
                                        title: Text(item.title),
                                        subtitle:
                                            Text('quantity ${item.quantity}'),
                                        trailing: Text('Ugx ${item.price}'),
                                      ))
                                  .toList(),
                            ),
                          ),
                          // order container
                        ],
                      );
                    });
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'You Don\'t have orders!!',
                          style: TextStyle(fontSize: 35),
                        )),
                    Container(child: const Text('Go make some orders')),
                  ],
                );
              }
            }));
  }
}
