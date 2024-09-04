import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: buttonColor,
      child: ListView(
        children: [
          Container(
            height: 200,
            color: buttonColor,
            child: Image.asset("assets/img/icon_drawer.png", fit: BoxFit.fill, color: Colors.white,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: containerBackgroundColor,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeNameAddBusPage);
                },
                leading: const Icon(Icons.bus_alert),
                iconColor: Colors.white,
                title: const Text(
                  'Add Bus',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: Fonts.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: containerBackgroundColor,
              ),
              child: ListTile(
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeNameAddRoutePage);
                },
                leading: const Icon(Icons.route),
                title: const Text(
                  'Add Route',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: Fonts.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: containerBackgroundColor,
              ),
              child: ListTile(
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeNameAddSchedulePage);
                },
                leading: const Icon(Icons.schedule),
                title: const Text(
                  'Add Schedule',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: Fonts.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: containerBackgroundColor,
              ),
              child: ListTile(
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeNameReservationPage);
                },
                leading: const Icon(Icons.book_online),
                title: const Text(
                  'View Reservations',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: Fonts.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: containerBackgroundColor,
              ),
              child: ListTile(
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeNameLoginPage);
                },
                leading: const Icon(Icons.login_outlined),
                title: const Text(
                  'Admin Login',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: Fonts.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
