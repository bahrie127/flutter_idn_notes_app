import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_idn_notes_app/pages/first_page.dart';
import 'package:flutter_idn_notes_app/pages/profile_page.dart';
import 'package:flutter_idn_notes_app/pages/search_page.dart';
import 'package:flutter_idn_notes_app/pages/setting_page.dart';
import 'package:flutter_idn_notes_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_idn_notes_app/presentation/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  void onTapHandler(int value) {
    setState(() {
      index = value;
    });
  }

  List<Widget> contents = [
    const FirstPage(),
    const SearchPage(),
    const ProfilePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Budi Sudarsono',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {},
              ),
              const Divider(),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                }
                if (state is LogoutFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return IconButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(LogoutButtonPressed());
                  },
                  icon: const Icon(Icons.logout_outlined),
                );
              },
            ),
          ],
        
        ),
        body: contents[index],
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          onTap: (value) {
            onTapHandler(value);
          },
          currentIndex: index,
          selectedItemColor: Colors.blue,
        ));
  }
}
