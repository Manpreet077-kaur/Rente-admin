import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:renteadmin/model/dashboard_response.dart';
import 'package:renteadmin/screen/dashboard/dashboard_presenter.dart';
import '../../components/dashboard_info_card.dart';
import '../../untils/constants.dart';
import '../../untils/responsive_web_app.dart';

class DashBoardView extends StatefulWidget {
  String? totalUsers;
  String? totalPayment;
  DashBoardView(this.totalUsers,this.totalPayment,{
    Key? key,
  }) : super(key: key);

  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}
class _DashBoardViewState extends State<DashBoardView> implements DashBoardInterface{
  late DashBoardPresenter dashBoardPresenter;

  @override
  void initState() {
    super.initState();
    dashBoardPresenter = DashBoardPresenter(this);
    setState(() {
      dashBoardPresenter.doDashBoard();
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: Constants.defaultPadding),
        ResponsiveWebApp(
          mobile: InfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: InfoCardGridView(),
          desktop: InfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,total_user:widget.totalUsers.toString(),totalPayment:widget.totalPayment
          ),
        ),
      ],
    );
  }

  @override
  onError(String msg, int errorCode) {

  }

  @override
  onSuccess(DashboardResponse user) {
    setState(() {
     widget.totalUsers=user.data!.totalUsersInApp!.toString();
     widget.totalPayment=user.data!.payment!.toString();
    });
  }
}

class InfoCardGridView extends StatelessWidget {
  final String? total_user;
  final String? totalPayment;
   InfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.total_user,
    this.totalPayment
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (child:Row(children: [
      Container(
        width: 140,
        height: 140,
        padding: EdgeInsets.all(Constants.defaultPadding),
        decoration: BoxDecoration(
            color: HexColor("#F19900"),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Users", maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  total_user.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
      SizedBox(width: 22,),
      Container(
        width: 140,
        height: 140,
        padding: EdgeInsets.all(Constants.defaultPadding),
        decoration: BoxDecoration(
            color: HexColor("#F19900"),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Payment", maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalPayment.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      )
    ],));
  }
}
