
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../route/route_name.dart';
import '../route/route_observer.dart';
import '../untils/responsive.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with RouteAware {
  String? _selectedRoute;
  AppRouteObserver? _routeObserver;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
             Center(
               child: Container(
                         margin: EdgeInsets.all(42),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 60,
                        )),
             ),
                DrawerListTile(
                  title: "    Dashboard",
                  svgSrc: "assets/images/dashboard.png",
                  press: () async {
                    await _navigateTo(context, RouteNames.dashboard);
                  },
                ),
                ExpansionTile(
                  iconColor: HexColor("#F19900"),
                  collapsedIconColor: HexColor("#F19900"),
                  title: Text("User Management",
                      style: TextStyle(color: HexColor("#F19900"))),
                  leading: Image.asset("assets/images/user.png",
                    color: HexColor("#F19900"),
                    height: 16,),
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await _navigateTo(context, RouteNames.selleruser);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 70,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Seller", style: TextStyle(color: HexColor("#F19900"),fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        await _navigateTo(context, RouteNames.customeruser);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 70,top: 20,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Customer", style: TextStyle(color: HexColor("#F19900"),fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                DrawerListTile(
                  title: "    Properties",
                  svgSrc: "assets/images/icon_property.png",
                  press: () async {
                    await _navigateTo(context, RouteNames.propertyListScreen);
                  },
                ),
                DrawerListTile(
                  title: "    Native Ads",
                  svgSrc: "assets/images/icon_ads.png",
                  press: () async {
                    await _navigateTo(context, RouteNames.nativeAdsListScreen);
                  },
                ),
                DrawerListTile(
                  title: "    Change Password",
                  svgSrc: "assets/images/icon_changepwd.png",
                  press: () async {
                    await _navigateTo(context, RouteNames.changePasswordScreen);

                  },
                ),
                DrawerListTile(
                  title: "    Logout",
                  svgSrc: "assets/images/logout.png",
                  press: () {
                    showAlertLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
          if (widget.permanentlyDisplay)
            const VerticalDivider(
              width: 1,
            )
        ],
      ),
    );
  }
  Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (widget.permanentlyDisplay) {
      Navigator.pop(context);
    }
    await Navigator.pushNamed(context, routeName);
  }

  showAlertLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          actions: [
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              width:  Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery.of(context).size.width/4,
                  context: context),
              height:  Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery.of(context).size.height/3,
                  context: context),
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40,bottom: 10.0),
                    child: Center(
                      child: Image.asset("assets/images/logo.png",height: 60,color: Colors.black,
                        width: MediaQuery.of(context).size.width/2.5,),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child:
                    Text("Are you sure want to log out?",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: HexColor("#F19900"))
                            ),
                            child: Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                          ),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: (){
                             /* setState(() {
                                isLoading=true;
                              });*/
                              //_authService.logout(context);
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#F19900"),
                              ),
                              child: Text("Log Out",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context)!.settings.name;
    });
  }
}
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        svgSrc,
        color: HexColor("#F19900"),
        height: 16,
      ),
      title: Text(
          title,
          style: TextStyle(color: HexColor("#F19900"))
      ),
    );
  }

}