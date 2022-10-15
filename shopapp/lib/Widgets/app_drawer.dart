import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/Routes/routes.dart';
import 'package:shopapp/Screens/input_screen.dart';
import 'package:shopapp/Screens/product_overviewScreen.dart';
import 'package:shopapp/Services/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan[100]),
              child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1593104547489-5cfb3839a3b5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjV8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
              ),
              Text('${Auth().auth.currentUser!.email}')
            ],
          )),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
              size: 30,
            ),
            title: Text(
              'Shop',
              style: GoogleFonts.tangerine(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProductOverView.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.payment,
              size: 30,
            ),
            title: Text(
              'Orders',
              style: GoogleFonts.tangerine(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
              size: 30,
            ),
            title: Text(
              'Manage Products',
              style: GoogleFonts.tangerine(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProductInputScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.login_outlined,
              size: 30,
            ),
            title: Text(
              'Log Out',
              style: GoogleFonts.tangerine(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Auth().logOut();
            },
          ),
        ],
      ),
    );
  }
}
