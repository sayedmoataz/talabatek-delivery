import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Model/notification_model.dart';
import '../../bloc/Cubit/AppCubit.dart';
import '../../bloc/Cubit/AppStates.dart';
import '../component/LoadingShimmer.dart';
import '../component/conditional_builder.dart';
import '../component/empty_widget.dart';
import '../component/text_style.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getNotification(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (AppCubit.get(context).notificationModel == null) {
            return VListLoading(
              scroll: Axis.vertical,
            );
          } else
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Notifications".tr(),
                  style: textStyle(context,
                      size: 20.sp, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: conditionalBuilder(
                    condition: AppCubit.get(context)
                            .notificationModel!
                            .results!
                            .length >
                        0,
                    builder: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildNotificationItem(
                        context,
                        AppCubit.get(context)
                            .notificationModel!
                            .results![index],
                        index,
                      ),
                      itemCount: AppCubit.get(context)
                          .notificationModel!
                          .results!
                          .length,
                    ),
                    fallback:
                        Center(child: EmptyWidget('No Notifications yet'.tr())),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  Widget buildNotificationItem(context, Results model, index) {
    return Card(
      margin: EdgeInsets.all(6.0),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 45.h,
            ),
            // SizedBox(width: 5.w),
            Expanded(
              child: Container(
                height: 60.h,
                child: ListTile(
                  title: Text(model.title!),
                  subtitle: Text(model.description!),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              height: 60.h,
              width: 115.w,
              alignment: Alignment.center,
              child: ListTile(
                title: Text(
                  DateFormat.yMMMd().format(DateTime.parse(model.createdAt!.toString())),
                  style: textStyle(context,size: 10.sp, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  DateFormat.jm().format(DateTime.parse(model.createdAt!.toString())),
                  textAlign: TextAlign.center,
                  style: textStyle(context, size: 10.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
