import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:delivery/utils/constants.dart';
import 'package:delivery/view/component/CustomTextField.dart';
import 'package:delivery/view/component/loadingScreen_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../component/text_style.dart';

class PersonalDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        //backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "Personal Data".tr(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
          ),
        ),
        actions: [
          SizedBox(
            width: screenSize.width * 0.1,
          )
        ],
      ),
      body: cubit.userModel == null ? LoadingScreen(): Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        width: screenSize.width,
        height: screenSize.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(cubit.userModel!.image ?? 'https://i.imgur.com/7vHILrC.jpeg'),
                        ),
                      ),

                    ],
                  ),
                  onTap: () {
                    print("clicked on avatar");
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Full Name".tr(),
                style: TextStyle(
                  color: AppCubit.get(context).themeMode == true ? Colors.white54: kGrey.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFiled(screenSize: screenSize, hintText: cubit.userModel!.name ?? ''),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email".tr(),
                style: TextStyle(
                  color: AppCubit.get(context).themeMode == true ? Colors.white54:kGrey.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFiled(
                  screenSize: screenSize, hintText: cubit.userModel!.email!),
              SizedBox(
                height: 10,
              ),
              Text(
                "Phone Number".tr(),
                style: TextStyle(
                  color:AppCubit.get(context).themeMode == true ? Colors.white54: kGrey.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFiled(
                  screenSize: screenSize, hintText: cubit.userModel!.phone!),
              SizedBox(
                height: 10,
              ),
              Text(
                "Password".tr(),
                style: TextStyle(
                  color:AppCubit.get(context).themeMode == true ? Colors.white54: kGrey.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFiled(
                screenSize: screenSize,
                hintText: "•••••••••••••",
                isForPasword: false,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Address".tr(),
                style: TextStyle(
                  color:AppCubit.get(context).themeMode == true ? Colors.white54: kGrey.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFiled(
                  screenSize: screenSize, hintText: cubit.userModel!.address ?? 'Not Added'),
              SizedBox(
                height: 155,
              ),
              Card(
                child: TextButton(
                    onPressed: () async{
                      showDialog(context: context, builder: (context){
                        return  AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          title: Image.asset('assets/images/logo.png'
                              ,alignment: Alignment.center,fit: BoxFit.contain,height: 120.h),
                          content: Text("Delete Account".tr(),style: textStyle(
                            context,
                            size: 20,
                            fontWeight: FontWeight.w600,
                          ),textAlign: TextAlign.center),
                          actions: [
                            Column(
                              children: [
                                Text(
                                  "Are your sure you want to delete account ?".tr(),style:textStyle(
                                  context,

                                ),textAlign: TextAlign.center
                                  ,),

                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    InkWell(
                                      onTap:(){
                                        cubit.deleteAcc(context, cubit.userModel!.id!);

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height:30,
                                        width:80,
                                        child: Text("Yes".tr(),style: textStyle(
                                          context,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,

                                        ),),
                                        decoration:BoxDecoration(
                                            color:AppCubit.get(context).primaryColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap:()=>Navigator.pop(context),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height:30,
                                        width:80,
                                        child: Text("No".tr(),style: textStyle(
                                          context,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,

                                        ),),
                                        decoration:BoxDecoration(
                                            color:Colors.red,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      });

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete_outline,color: Colors.red,),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Delete Account'.tr(),style:textStyle(context,size: 18.sp,color: AppCubit.get(context).themeMode == true ? Colors.grey[300] : Colors.black),),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
