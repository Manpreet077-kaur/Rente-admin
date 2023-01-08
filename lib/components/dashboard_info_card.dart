import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../untils/constants.dart';

class DashBoardInfoCard extends StatelessWidget {
  String total_user;
  String totalPayment;
   DashBoardInfoCard({
    Key? key, required this.total_user,required this.totalPayment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Row(children: [
        Container(
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
        Container(
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
      ],),
    );
  }
}
