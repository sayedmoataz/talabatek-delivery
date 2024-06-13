import 'dart:async';

import 'package:delivery/Model/order_model.dart';
import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:delivery/utils/constants.dart';
import 'package:delivery/view/component/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screen/order_details_screen.dart';

class CommandWidget extends StatelessWidget {
  const CommandWidget(
      {this.status,
      this.clientName,
      this.price,
      this.location,
      this.notes,
      this.dropOffAddress,
      this.phone,
      this.orderId,
      this.results,
      required this.screen});
  final String? status;
  final String? location;
  final String? clientName;
  final String? price;
  final String? phone;
  final String? notes;
  final String? dropOffAddress;
  final int? orderId;
  final OrderModelItem? results;
  final String? screen;
 /* void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: kPrimaryColor,
        ),
      ),
      child: ExpandablePanel(
        header: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${results!.id!}',
                      style: textStyle(context,
                          size: 18.sp,
                          color: AppCubit.get(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    // Spacer(),
                    //timer
                    results!.time != 0
                        ? OrderStatusWidget(
                            time: results!.time!,
                            updatedTime: convertTimeFromStringIntoDateTimeObj(
                                results!.updatedTime!))
                        : SizedBox(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                             // _makePhoneCall(phone!);
                              Clipboard.setData(ClipboardData(text: phone!))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "تم نسخ رقم الهاتف")));
                              });
                            },
                            icon: Icon(Icons.call)),
                        Column(
                          children: [
                            Text(
                              clientName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              phone ?? '',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$price ₪",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          status == 'finished'
                              ? 'جديد'
                              : status == 'started'
                                  ? 'started'.tr()
                                  : status == 'preparing'
                                      ? 'preparing'.tr()
                                      : status == 'in the way'
                                          ? 'in the way'.tr()
                                          : status == 'complete'
                                              ? 'complete'.tr()
                                              : status!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: status == 'finished'
                                  ? Colors.amber
                                  : status == 'started'
                                      ? Colors.green
                                      : status == 'preparing'
                                          ? Colors.indigo
                                          : status == 'in the way'
                                              ? Colors.orange
                                              : status == 'complete'
                                                  ? Colors.green
                                                  : Colors.red,
                              fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        collapsed: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Restaurants".tr(),
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  child: ListView.separated(
                      itemCount: results!.cartProducts!.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => Text('  -  '),
                      itemBuilder: (context, index) {
                        return Text(
                            results!.cartProducts![index].product!.user!.name ??
                                '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13));
                      }),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Text(
                  "Detailed address".tr(),
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(notes ?? '',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "DROP OFF".tr(),
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(
                                  ClipboardData(text: dropOffAddress!))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Address copied to clipboard".tr())));
                          });
                        },
                        icon: Icon(Icons.copy)),
                    Text(
                        dropOffAddress!.length < 30
                            ? dropOffAddress!
                            : dropOffAddress!.substring(0, 30) + '...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    IconButton(
                        onPressed: () async {
                        /*  await launch(
                              'https://www.google.com/maps/search/?api=1&query=$location');*/
                          Clipboard.setData(ClipboardData(text: dropOffAddress!))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "تم نسخ العنوان")));
                          });
                        },
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: AppCubit.get(context).primaryColor,
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: screen == "allOrders"
                          ? () {
                              AppCubit.get(context)
                                  .checkOrder(orderId, context);
                            }
                          : () {
                              Scaffold.of(context).showBottomSheet(
                                (context) => SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height -
                                        380.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppCubit.get(context).themeMode ==
                                              true
                                          ? Colors.grey[800]
                                          : Colors.grey[100],
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(20),
                                        topStart: Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 300.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView(
                                              children: [
                                                SizedBox(
                                                  height: 30.h,
                                                ),
                                                Text(
                                                  'Change To'.tr(),
                                                  style: textStyle(context,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 14.sp),
                                                  textAlign: TextAlign.center,
                                                ),
                                                /*   InkWell(
                                          onTap: (){
                                            AppCubit.get(context).updateOrder(orderId, 'preparing', context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context).size.width,
                                            height: 35.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(color: AppCubit.get(context).primaryColor,width: 2)
                                            ),
                                            child: Text('preparing'.tr() ,
                                              style: textStyle(
                                                context,
                                                fontWeight: FontWeight.bold,
                                                size: 16.w,),),
                                          ),
                                        ),
                                        SizedBox(height: 10.h,),*/
                                                InkWell(
                                                  onTap: () {
                                                    AppCubit.get(context)
                                                        .updateOrder(
                                                            orderId,
                                                            'in the way',
                                                            context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 35.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        border: Border.all(
                                                            color: AppCubit.get(
                                                                    context)
                                                                .primaryColor,
                                                            width: 2)),
                                                    child: Text(
                                                      'in the way'.tr(),
                                                      style: textStyle(
                                                        context,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        size: 16.w,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    AppCubit.get(context)
                                                        .updateOrder(
                                                            orderId,
                                                            'complete',
                                                            context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 35.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        border: Border.all(
                                                            color: AppCubit.get(
                                                                    context)
                                                                .primaryColor,
                                                            width: 2)),
                                                    child: Text(
                                                      'complete'.tr(),
                                                      style: textStyle(
                                                        context,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        size: 16.w,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                      child: Container(
                        width: 160.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppCubit.get(context).primaryColor),
                        child: Text(
                          screen == "allOrders"
                              ? 'Accept'.tr()
                              : 'Change Status'.tr(),
                          style: textStyle(context,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              size: 16.sp),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailsScreen(results)));
                      },
                      child: Container(
                        width: 160.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.blueAccent),
                        child: Text(
                          'Details'.tr(),
                          style: textStyle(context,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              size: 16.sp),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        expanded: Container(),
      ),
    );
  }
}

class OrderStatusWidget extends StatefulWidget {
  final int time; // Time the order takes to be ready
  final DateTime updatedTime;

  const OrderStatusWidget(
      {super.key, required this.time, required this.updatedTime});

  @override
  _OrderStatusWidgetState createState() => _OrderStatusWidgetState();
}

class _OrderStatusWidgetState extends State<OrderStatusWidget> {
  Duration _remainingTime = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    // log(widget.time.toString());
    // log(widget.updatedTime.toString());
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void didUpdateWidget(OrderStatusWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If time or updatedTime changes, recalculate and restart the timer
    if (widget.time != oldWidget.time ||
        widget.updatedTime != oldWidget.updatedTime) {
      _calculateRemainingTime();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    final deadline = widget.updatedTime.add(Duration(minutes: widget.time));
    // log(widget.updatedTime.toString());
    // log(deadline.toString());
    // log(now.toString());
    setState(() {
      _remainingTime =
          deadline.isAfter(now) ? deadline.difference(now) : Duration.zero;
      // log(_remainingTime.toString());
    });
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateRemainingTime(); // Update the UI every second
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_formatDuration(_remainingTime)}',
    );
  }

  String _formatDuration(Duration duration) {
    // Adjust formatting as needed
    return duration == Duration.zero
        ? 'جاهز'
        : '${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}

DateTime convertTimeFromStringIntoDateTimeObj(String date) {
  DateFormat format =
      DateFormat("EEEE, MMMM d, y 'at' hh:mm:ss a",  'en');
  return format.parse(date);
}
