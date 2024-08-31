import 'package:flutter/material.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'package:lifelinekerala/service/store_service.dart';
import 'package:lifelinekerala/view/dashboard/dashboard.dart';
import 'package:lifelinekerala/view/help_provided_list/help_provided_list.dart';
import 'package:lifelinekerala/view/help_provided_list/help_received_list.dart';
import 'package:lifelinekerala/view/home_screen/drawer/widget/drawer_widget.dart';
import 'package:lifelinekerala/view/login/login_screen.dart';
import 'package:lifelinekerala/view/notification_screen/notifiaction.dart';
import 'package:lifelinekerala/view/profile_screen/profile.dart';
import 'package:lifelinekerala/view/transaction/transaction.dart';
import 'package:lifelinekerala/view/welcome_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // DrawerHeader(
              //   margin: EdgeInsets.zero,
              //   padding: EdgeInsets.zero,
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: Image.asset(
              //           'assets/logo.png',
              //           width: 64,
              //           height: 64,
              //         ),
              //       ),
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.all(16.0),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               const Align(
              //                 alignment: Alignment.centerLeft,
              //                 child: Text(
              //                   'LifeLineKerala',
              //                   style: TextStyle(
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              MyListTile(
                imagePath: 'assets/user.png',
                text: 'Profile',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                ),
              ),
              MyListTile(
                imagePath: 'assets/dashboardicon.png',
                text: 'Dashboard',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashBoardScreen(),
                    ),
                  );
                },
              ),
              MyListTile(
                imagePath: 'assets/transactionicon.png',
                text: 'Transaction',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionScreen(),
                    ),
                  );
                },
              ),
              MyListTile(
                imagePath: 'assets/helpprovided.png',
                text: 'Help Provided list',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpProvidedList(),
                    ),
                  );
                },
              ),
              MyListTile(
                imagePath: 'assets/info.png',
                text: 'Help Received list',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpReceivedScreen(),
                    ),
                  );
                },
              ),
              MyListTile(
                imagePath: 'assets/bell.png',
                text: 'Notification',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: MyListTile(
              imagePath: 'assets/logout.png',
              text: 'L O G O U T',
              onTap: () async {
                await ApiService().logout(); // Ensure device token is removed
                await StoreService().clearValues();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                ); // Clear stored credentials
              },
            ),
          ),
        ],
      ),
    );
  }
}
