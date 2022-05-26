import 'package:fitnessapp/resources/appcolors.dart';
import 'package:fitnessapp/route/router.dart';
import 'package:fitnessapp/screens/dashboard/diet/dietpage.dart';
import 'package:fitnessapp/screens/dashboard/homepage/homepage.dart';
import 'package:fitnessapp/screens/dashboard/profile/profilepage.dart';
import 'package:fitnessapp/screens/setting/setting.dart';
import 'package:flutter/material.dart';

class NavigationHandlerPage extends StatefulWidget {
  const NavigationHandlerPage({Key? key}) : super(key: key);

  @override
  _NavigationHandlerPageState createState() => _NavigationHandlerPageState();
}

class _NavigationHandlerPageState extends State<NavigationHandlerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const ProfilePage(),
    const DietPage(),
    // const NewsPage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, recommendationPageRoute);
        },
        child: const Icon(Icons.local_fire_department),
        elevation: 2.0,
        backgroundColor: AppColors.mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.white,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: 'Home',
              icon: Icon(Icons.home,
                  color:
                      currentTab == 0 ? Colors.green.shade900 : Colors.black54),
              onPressed: () {
                setState(() {
                  currentScreen = const HomePage();
                  currentTab = 0;
                });
              },
            ),
            IconButton(
              tooltip: 'Diet',
              icon: Icon(Icons.dining,
                  color:
                      currentTab == 1 ? Colors.green.shade900 : Colors.black54),
              onPressed: () {
                setState(() {
                  currentScreen = const DietPage();
                  currentTab = 1;
                });
              },
            ),
            const SizedBox(
              width: 50,
            ),
            IconButton(
              tooltip: 'Recommendation',
              icon: Icon(Icons.pending_actions_outlined,
                  color:
                      currentTab == 2 ? Colors.green.shade900 : Colors.black54),
              onPressed: () {
                setState(() {
                  currentScreen = const SettingPage();
                  currentTab = 2;
                });
              },
            ),
            IconButton(
              tooltip: 'Profile',
              icon: Icon(Icons.account_box_rounded,
                  color:
                      currentTab == 3 ? Colors.green.shade900 : Colors.black54),
              onPressed: () {
                setState(() {
                  currentScreen = const ProfilePage();
                  currentTab = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
