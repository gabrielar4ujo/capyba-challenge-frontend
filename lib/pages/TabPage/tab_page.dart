import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/CreateEventPage/create_event_page.dart';
import 'package:capyba_challenge_frontend/pages/HomePage/home_page.dart';
import 'package:capyba_challenge_frontend/pages/LoginPage/login_page.dart';
import 'package:capyba_challenge_frontend/pages/ProfilePage/profile_page.dart';
import 'package:capyba_challenge_frontend/pages/RestrictedPage/restricted_page.dart';
import 'package:capyba_challenge_frontend/pages/TabPage/widgets/custom_drawer.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_header.dart';
import 'package:capyba_challenge_frontend/utils/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context);
    final sideBarOptions = [
      {
        "name": Labels.get("myProfile"),
        "onPress": () {
          _scaffoldkey.currentState!.openEndDrawer();
          _navigateToRegister();
        }
      },
      {
        "name": Labels.get("validateEmail"),
        "onPress": () async {
          try {
            await _authService.sendEmailVerification();
            GlobalSnackbar.showMessage(
                context, Labels.get("verificationEmailSent"));
          } on FirebaseServicesException catch (e) {
            GlobalSnackbar.showMessage(context, Labels.get(e.code));
          } finally {
            _scaffoldkey.currentState!.openEndDrawer();
          }
        }
      }
    ];
    final List<Widget> _widgetOptions = <Widget>[
      const HomePage(),
      const RestrictedPage()
    ];

    void _logOut() async {
      await _authService.logout();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(AppColors.get("accentPink")),
      ),
      drawer: CustomDrawer(
        items: sideBarOptions.sublist(0, _authService.emailVerified ? 1 : 2),
        onPressExit: _logOut,
        photoUrl: _authService.photoUrl,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomHeader(
            title: _selectedIndex == 0
                ? Labels.get("publicEvents")
                : Labels.get("privateEvents"),
            leftIcon: const Icon(Icons.menu),
            onPress: () => _scaffoldkey.currentState!.openDrawer(),
          ),
          Flexible(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(AppColors.get('lightGray')),
        child: Icon(
          Icons.add,
          color: Color(AppColors.get('darkBlue')),
        ),
        onPressed: _authService.emailVerified
            ? _navigateToCreateEvent
            : () async {
                try {
                  await _authService.reloadUser();
                  if (!_authService.emailVerified) {
                    GlobalSnackbar.showMessage(
                        context, Labels.get("checkYourEmailToCreateEvent"));
                  } else {
                    _navigateToCreateEvent();
                  }
                } catch (e) {
                  GlobalSnackbar.showMessage(
                      context, Labels.get("checkYourEmailToCreateEvent"));
                }
              },
      ),
      backgroundColor: Color(AppColors.get("accentPink")),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(AppColors.get("darkBlue")),
        unselectedItemColor: Color(AppColors.get("lightGray")),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: Labels.get("home"),
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.lock),
            icon: const Icon(Icons.lock_outline),
            label: Labels.get("restricted"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(AppColors.get("accentPink")),
        onTap: _onItemTapped,
      ),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  void _navigateToCreateEvent() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateEventPage()));
  }
}
