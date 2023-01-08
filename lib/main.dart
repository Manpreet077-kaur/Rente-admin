import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:renteadmin/onNativeAds/nativeads_list_screen.dart';
import 'package:renteadmin/screen/changepassword/changepwd_screen.dart';
import 'package:renteadmin/screen/onBoarding/onboard_list_screen.dart';
import 'package:renteadmin/screen/propertyList/property_list_screen.dart';
import 'package:renteadmin/screen/user/customer_user_screen.dart';
import 'package:renteadmin/screen/user/seller_user_screen.dart';
import 'package:renteadmin/untils/sharedpref/shared_prefrence.dart';
import 'route/route_name.dart';
import 'screen/dashboard/dashboard_screen.dart';
import 'screen/login/login_screen.dart';
import 'screen/profile/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options:  const FirebaseOptions(
          apiKey: "AIzaSyBYwYdNjwV3eVXD7Nc7JqRz-NZbjvZxfYw",
          authDomain: "skicka-mig-8de6e.firebaseapp.com",
          projectId: "skicka-mig-8de6e",
          storageBucket: "skicka-mig-8de6e.appspot.com",
          messagingSenderId: "523031531805",
          appId: "1:523031531805:web:698fb3d1a06f3b706851f4",
          measurementId: "G-L19KZPHYBM"
      )
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State {
  @override
  initState() {
    SessionManager.init();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RenteAdmin',
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: bgColor,
      //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      //       .apply(bodyColor: Colors.white),
      //   canvasColor: secondaryColor,
      // ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(
          // makes all platforms that can run Flutter apps display routes without any animation
          builders: Map<TargetPlatform,
              _InanimatePageTransitionsBuilder>.fromIterable(
              TargetPlatform.values.toList(),
              key: (dynamic k) => k,
              value: (dynamic _) => const _InanimatePageTransitionsBuilder()),
        ),
      ),
      initialRoute: RouteNames.login,
      navigatorObservers: [RouteObserver()],
      routes: {
        RouteNames.login: (_) =>  LoginScreen(),
        RouteNames.dashboard: (_) =>  const DashboardScreen(),
        RouteNames.selleruser: (_) =>  SellerUserScreen(),
        RouteNames.customeruser: (_) =>  CustomerUserScreen(),
        RouteNames.profile: (_) =>  ProfileScreen(),
        RouteNames.changePasswordScreen: (_) =>  ChangePasswordScreen(),
        RouteNames.propertyListScreen: (_) =>  PropertyListScreen(),
        RouteNames.onBoardingListScreen: (_) =>  OnboardListScreen(),
        RouteNames.nativeAdsListScreen: (_) =>  NativeAdsListScreen(),
      },
      home: LoginScreen(),
    );
  }
}
/// This class is used to build page transitions that don't have any animation
class _InanimatePageTransitionsBuilder extends PageTransitionsBuilder {
  const _InanimatePageTransitionsBuilder();
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}