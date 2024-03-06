import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/customDrawer.dart';
import 'package:fit_friend/fireStoreHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FireStoreHelper fireStore = FireStoreHelper.instance;

  @override
  void initState() {
    super.initState();
    // check and add user to Firestore
    fireStore.checkAndAddUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      key: Key('Home Page'),
      backgroundColor: Color(0xFFE2E2E2),
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Center(
        child: Text(
          'Welcome to your fitness app!',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
