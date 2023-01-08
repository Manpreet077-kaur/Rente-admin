
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/app_side_menu.dart';
import '../../components/header.dart';
import '../../untils/constants.dart';
import '../../untils/responsive_web_app.dart';
import 'dashboard_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var totalUsers=0;
  var totalPayment=0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
        pageTitle: "Dashboard",
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: HexColor("#EFF1F5"),
            child: Column(
              children: [
                Header(title: "Dashboard",type:0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.white
                  ),
                  margin: EdgeInsets.all(22),
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            DashBoardView(totalUsers.toString(),totalPayment.toString()),
                             SizedBox(height: Constants.defaultPadding),
                            if (ResponsiveWebApp.isMobile(context))
                              SizedBox(height: Constants.defaultPadding),
                          ],
                        ),
                      ),
                      if (!ResponsiveWebApp.isMobile(context))
                         SizedBox(width: Constants.defaultPadding),
                      // On Mobile means if the screen is less than 850 we dont want to show it
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }


}
