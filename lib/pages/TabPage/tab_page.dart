import 'package:capyba_challenge_frontend/pages/LoginPage/login_page.dart';
import 'package:capyba_challenge_frontend/pages/ProfilePage/profile_page.dart';
import 'package:capyba_challenge_frontend/pages/TabPage/widgets/custom_drawer.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_header.dart';
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
        "name": "Meu perfil",
        "onPress": () {
          _scaffoldkey.currentState!.openEndDrawer();
          _navigateToRegister();
        }
      },
      {
        "name": "Validar email",
        "onPress": () async {
          try {
            await _authService.sendEmailVerification();
            _scaffoldkey.currentState!.openEndDrawer();
            _showSnackBar("Email de verificação enviado!");
          } catch (e) {
            _showSnackBar("error");
          }
        }
      }
    ];
    final List<Widget> _widgetOptions = <Widget>[
      Text(
        'Home: Aberto',
        style: optionStyle,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Restrito: Está restrito? R: ${_authService.emailVerified() ? 'Não' : 'Sim'}',
            style: optionStyle,
          ),
          CustomButton(
            onPressed: () async {
              try {
                await _authService.reloadUser();
              } catch (e) {
                print(e);
              }
            },
            text: "Já validei meu email",
          )
        ],
      ),
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
        items: sideBarOptions,
        onPressExit: _logOut,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomHeader(
            title: "Eventos",
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
        backgroundColor: Color(AppColors.get('white92')),
        child: Icon(
          Icons.add,
          color: Color(AppColors.get('darkBlue')),
        ),
        onPressed: () async {
          // await _authService.reloadUser();
          // print(_authService.user!.emailVerified);
          // await _authService.logout();
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const LoginPage()));
        },
      ),
      backgroundColor: Color(AppColors.get("accentPink")),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(AppColors.get("darkBlue")),
        unselectedItemColor: Color(AppColors.get("white92")),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.lock),
            icon: Icon(Icons.lock_outline),
            label: 'Restrito',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(AppColors.get("accentPink")),
        onTap: _onItemTapped,
      ),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
}
