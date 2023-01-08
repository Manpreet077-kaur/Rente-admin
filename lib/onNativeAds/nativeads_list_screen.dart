import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:renteadmin/model/advertise_response.dart';
import 'package:renteadmin/model/success_response.dart';
import '../../components/app_side_menu.dart';
import '../../components/header.dart';
import '../../untils/constants.dart';
import '../../untils/responsive.dart';
import '../../untils/responsive_web_app.dart';
import '../../widget/all_widgets.dart';
import '../../widget/full_image_view.dart';
import 'add_nativeads_screen.dart';
import 'edit_nativeads_screen.dart';
import 'nativeads_presenter.dart';


class NativeAdsListScreen extends StatefulWidget {
  @override
  _NativeAdsListScreenState createState() => _NativeAdsListScreenState();
}

class _NativeAdsListScreenState extends State<NativeAdsListScreen> implements NativeAdsInterface{
  var isLoading = false;
  List<AdvertisementData> advertisementData=[];
  NativeAdsPresenter? nativeAdsPresenter;
  var status=1;
  var message="";
  @override
  void initState() {
    nativeAdsPresenter = NativeAdsPresenter(this);
    setState(() {
      isLoading=true;
      nativeAdsPresenter!.doOnBoardingList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppSideMenu( pageTitle: "Native Ads",
    body:  Stack(
      children: [
        Container(
          color: HexColor("#EFF1F5"),
          child: Column(
            children: [
              Header(title: "Native Ads",type:1),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Spacer(),
                  Text("Add Ads"),
                  SizedBox(width: 12,),
                 GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>AddNativeAdsScreen()));
                    },
                    child: Image.asset("assets/images/iocn_plus.png",height: 22, width: 22,)),
                  SizedBox(width: 64,)
              ],),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:4,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          height: MediaQuery.of(context).size.height/1.3,
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
                              advertisementData.length, (index) => recentFileDataRow(advertisementData[index],index+1,context),
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
  onNativeAdsListSuccess(AdvertisementResponse advertisementResponse) {
    setState(() {
      isLoading=false;
      advertisementData.addAll(advertisementResponse.data!);
    });

  }

  @override
  onAddNativeAdsSuccess(SuccessResponse user) {

  }


  @override
  onAdsDisableSuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });
    setState(() {
      isLoading=true;
      advertisementData.clear();
      nativeAdsPresenter!.doOnBoardingList();
    });
  }

  DataRow recentFileDataRow(AdvertisementData advertisementData, int index,BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(index.toString())),
        DataCell(Text(advertisementData.title!)),
        DataCell(Text(advertisementData.url!)),
        DataCell(
    advertisementData.image!.isEmpty?Container(): GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) {
                        return FullScreenImage(
                          imageUrl:Constants.BASE_URL_IMAGE+advertisementData.image!,
                          tag: "back_image",
                        );
                      }));
                }, child:CircleAvatar(
                radius: 14, // Image radius
                backgroundImage: NetworkImage(Constants.BASE_URL_IMAGE+advertisementData.image!,)))
        ),
        DataCell(Row(
          children: [
            GestureDetector(
                onTap: (){
                  showDisableAdsDialog( context,  advertisementData.sId.toString(),  advertisementData.status);
                },
                child: Image.asset("assets/images/ic_disable.png",height: 16, width: 16,color: advertisementData.status==true?Colors.green:Colors.red,)),
            SizedBox(width:12),
            GestureDetector(
                onTap: (){
                  print("image show::"+Constants.BASE_URL_IMAGE+advertisementData.image.toString());
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>EditNativeScreen(onAdsName:advertisementData.title.toString(),onAdsId: advertisementData.sId.toString(),onAdsURL: advertisementData.url.toString(),imageUrl: Constants.BASE_URL_IMAGE+advertisementData.image.toString(),)));

                },
                child: Image.asset("assets/images/icon_edit.png",height: 16, width: 16,color:Colors.black)),

            SizedBox(width:4),

          ],
        )),
      ],
    );

  }
  showDisableAdsDialog(BuildContext context, String user_id, bool? isDisable) {
    if(isDisable==false){
      message="Are you sure want to disable this ads?";
      status=1;
    }
    else{
      message="Are you sure want to enable this ads?";
      status=0;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          actions: [
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
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
                      child: Image.asset("assets/images/logo.png",height: 30,color: Colors.black,
                        width: MediaQuery.of(context).size.width/2.5,),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child:
                    Text(message,style: const TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
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
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:Container(
                                width: 120,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(top: 30.0,bottom: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: HexColor("#112153"))
                                ),
                                child: Text("No",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                              )),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isLoading=true;
                              });
                              nativeAdsPresenter!.doAdsDisablePost(user_id, status.toString());
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#65A2A2"),
                              ),
                              child: const Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
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

  @override
  onEditAdsSuccess(SuccessResponse user) {

  }



}

