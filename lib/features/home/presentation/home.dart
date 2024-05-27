import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/bottom_navigation/bottom_nav_widget.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/request_page.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/presentation/banner_page.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/presentation/profile_page.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/presentation/tests_screen.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationWidget(
      text1: 'Request',
      text2: 'Tests',
      text3: 'Banner',
      text4: 'Profile',
      tabItems: const [
        RequestScreen(),
        TestsScreen(),
        BannerScreen(),
        ProfileScreen(),
      ],
      selectedImage: Image.asset(
        BIcon.testsColor,
        height: 28,
        width: 28,
      ),
      unselectedImage: Image.asset(
        BIcon.testsBlack,
        height: 28,
        width: 28,
      ),
    ));
  }
}
