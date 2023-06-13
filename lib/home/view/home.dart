import 'package:flutter/material.dart';
import 'package:qr_scanner/history/view/history.dart';
import 'package:qr_scanner/qr_screen/qr_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myItem = 0;
  List<Widget> widgetList = [QRScreen(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: widgetList,
        index: myItem,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          color: Colors.red,
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            onTabChange: (item) {
              setState(() {
                myItem = item;
              });
            },
            tabs: [
              GButton(
                icon: Icons.qr_code_2_outlined,
                text: 'QR Scanner',
              ),
              GButton(
                icon: Icons.history_outlined,
                text: 'History',
              ),
            ],
            backgroundColor: Colors.red,
            tabBackgroundColor: Colors.white.withOpacity(0.2),
            padding: EdgeInsets.all(18),
            color: Colors.white,
            activeColor: Colors.white,
            gap: 10,
          ),
        ),
      ),
    );
  }
}
