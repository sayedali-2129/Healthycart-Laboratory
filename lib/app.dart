import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/di/injection.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/application/laboratory_form_provider.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/request_doctor_provider.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/application/add_banner_provider.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/application/profile_provider.dart';
import 'package:healthy_cart_laboratory/features/location_picker/location_picker/application/location_provider.dart';
import 'package:healthy_cart_laboratory/features/pending_page/application/pending_provider.dart';
import 'package:healthy_cart_laboratory/features/splash_screen/splash_screen.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/application/provider/test_provider.dart';
import 'package:healthy_cart_laboratory/main.dart';
import 'package:healthy_cart_laboratory/utils/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<LaboratoryFormProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<ProfileProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => RequestDoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<AddBannerProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<LocationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<AuthenticationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<PendingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<TestProvider>(),
        ),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: BAppTheme.lightTheme,
          darkTheme: BAppTheme.darkTheme,
          home: const SplashScreen()),
    );
  }
}
