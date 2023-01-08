import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:renteadmin/model/property_response.dart';
import 'package:renteadmin/model/success_response.dart';
import '../../components/app_side_menu.dart';
import '../../components/header.dart';
import '../../model/onBoarding_response.dart';
import '../../route/route_name.dart';
import '../../untils/constants.dart';
import '../../untils/responsive.dart';
import '../../untils/responsive_web_app.dart';
import '../../widget/all_widgets.dart';
import '../../widget/full_image_view.dart';
import 'addonboarding_screen.dart';
import 'onboard_presenter.dart';


class OnboardListScreen extends StatefulWidget {
  @override
  _OnboardListScreenState createState() => _OnboardListScreenState();
}

class _OnboardListScreenState extends State<OnboardListScreen> implements OnboardInterface{
  var isLoading = false;
  List<OnBordingData> onBordingData=[];
  OnboardPresenter? propertyPresenter;
  @override
  void initState() {
    propertyPresenter = OnboardPresenter(this);
    setState(() {
      isLoading=true;
      propertyPresenter!.doOnBoardingList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppSideMenu( pageTitle: "Property",
    body:  Stack(
      children: [
        Container(
          color: HexColor("#EFF1F5"),
          child: Column(
            children: [
              Header(title: "Properties",type:1),
              const SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:4,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.height/1.2,
                          margin: EdgeInsets.all(22),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              color: Colors.white
                          ),
                          child: DataTable2(
                            columnSpacing: Constants.defaultPadding,
                            minWidth: 600,
                            columns: const [
                              DataColumn(
                                label: Text("Sr.No."),
                              ),
                              DataColumn(
                                label: Text("Name"),
                              ),
                              DataColumn(
                                label: Text("Description"),
                              ),
                              DataColumn(
                                label: Text("Image"),
                              ),
                              DataColumn(
                                label: Text("Action"),
                              ),
                            /*  DataColumn(
                                label: Text("Show"),
                              ),*/
                            ],
                            rows: List.generate(
                              onBordingData.length, (index) => recentFileDataRow(onBordingData[index],index+1,context),
                            ),
                          ),
                        ),
                        // CategoryView(categoryList:categoryList,),
                        if (ResponsiveWebApp.isMobile(context))
                          SizedBox(height: Constants.defaultPadding),
                      ],
                    ),
                  ),
                  if (!ResponsiveWebApp.isMobile(context))
                    SizedBox(width: Constants.defaultPadding),
                ],
              )
            ],
          ),
        ),
        AllWidgets.progressDialogs(context, isLoading)
      ],
    ),
    );
  }


  @override
  onError(String msg) {
    setState(() {
      isLoading=false;
    });
  }

  @override
  onOnboardSuccess(OnboardingResponse onboardingResponse) {
    setState(() {
      isLoading=false;
      onBordingData.addAll(onboardingResponse.data!);
    });

  }

  @override
  onAddCategorySuccess(SuccessResponse user) {

  }

  }
  DataRow recentFileDataRow(OnBordingData onBordingData, int index,BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(index.toString())),
        DataCell(Text(onBordingData.title!)),
        DataCell(Text(onBordingData.description!,maxLines:2)),
        DataCell(
      GestureDetector(
          onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (_) {
              return FullScreenImage(
                imageUrl:Constants.BASE_URL_IMAGE+onBordingData.image!,
                tag: "back_image",
              );
            }));
      }, child:CircleAvatar(
              radius: 14, // Image radius
              backgroundImage: NetworkImage(Constants.BASE_URL_IMAGE+onBordingData.image!,)))
        ),
        DataCell(Row(
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>AddOnBoardingScreen(onBoardingId:onBordingData.sId.toString(),onBoardingName: onBordingData.title.toString(),onBoardingDescri: onBordingData.description.toString(),imageUrl: Constants.BASE_URL_IMAGE+onBordingData.image.toString(),)));

                },
                child: Image.asset("assets/images/icon_edit.png",height: 16, width: 16,color:Colors.black)),
            SizedBox(width:4),

          ],
        )),
      /*  DataCell(GestureDetector(
          onTap: (){
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: HexColor("#F19900")
            ),
            child:const Text("Show",style: TextStyle(color: Colors.white,fontSize: 12),) ,
          ),
        ),),*/
      ],
    );
  }



