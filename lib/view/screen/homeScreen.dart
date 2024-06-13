import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:delivery/view/component/CommandWidget.dart';
import 'package:delivery/view/component/text_style.dart';
import 'package:delivery/view/screen/sideDrawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../bloc/Cubit/AppStates.dart';
import '../component/LoadingShimmer.dart';
import '../component/conditional_builder.dart';
import '../component/empty_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context);
    return BlocProvider(
      create: (context) => AppCubit()
        ..getOrders()
        ..getUserData()
        ..getRealTimeOrders(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (AppCubit.get(context).orderModel == null) {
            return VListLoading(
              scroll: Axis.vertical,
            );
          } else
            return Scaffold(
                //   drawer: SideDrawer(),
                appBar: AppBar(
                  actions: [
                    GestureDetector(
                      child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Icon(Icons.notifications)),
                      onTap: () {
                        Navigator.of(context).pushNamed("/notification");
                      },
                    ),
                    SizedBox(width: 20)
                  ],
                  elevation: 0,
                  title: Text(
                    'New Orders'.tr(),
                    style: textStyle(
                      context,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        EasyLocalization.of(context)!.locale ==
                                Locale('en', 'US')
                            ? Navigator.of(context).push(
                                PageAnimationTransition(
                                    page: SideDrawer(),
                                    pageAnimationType: LeftToRightTransition()))
                            : Navigator.of(context).push(
                                PageAnimationTransition(
                                    page: SideDrawer(),
                                    pageAnimationType:
                                        RightToLeftTransition()));
                      },
                    ),
                  ),
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    await AppCubit.get(context).getOrders();
                  },
                  child: /*AppCubit.get(context).orderLoading ? LoadingScreen():*/
                      SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: AppCubit.get(context).orderLoading ? 0.5 : 1,
                          child: SingleChildScrollView(
                            child: conditionalBuilder(
                                condition: AppCubit.get(context)
                                        .orderModel!
                                        .results!
                                        .length >
                                    0,
                                builder: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      CommandWidget(
                                    results: AppCubit.get(context)
                                        .orderModel!
                                        .results![index],
                                    screen: "allOrders",
                                    orderId: AppCubit.get(context)
                                        .orderModel!
                                        .results![index]
                                        .id,
                                    clientName: AppCubit.get(context)
                                        .orderModel!
                                        .results![index]
                                        .name,
                                    phone: AppCubit.get(context)
                                        .orderModel!
                                        .results![index]
                                        .user!
                                        .phone,
                                    dropOffAddress: AppCubit.get(context)
                                        .orderModel!
                                        .results![index]
                                        .address,
                                    notes: AppCubit.get(context)
                                            .orderModel!
                                            .results![index]
                                            .notes ??
                                        '',
                                    price: AppCubit.get(context)
                                        .orderModel!
                                        .results![index]
                                        .total,
                                    location: AppCubit.get(context)
                                        .orderModel!
                                        .results![index]
                                        .location,
                                    status: AppCubit.get(context)
                                        .orderModel!
                                        .results![index]
                                        .status,
                                  ),
                                  itemCount: AppCubit.get(context)
                                      .orderModel!
                                      .results!
                                      .length,
                                ),
                                fallback: Center(
                                    child: EmptyWidget(
                                        'There are no orders yet!'.tr()))),
                          ),
                        ),
                        Center(
                          child: Opacity(
                            opacity:
                                AppCubit.get(context).orderLoading ? 1.0 : 0,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
        },
      ),
    );
  }
}
