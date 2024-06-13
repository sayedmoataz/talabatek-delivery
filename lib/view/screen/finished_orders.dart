import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:delivery/view/component/CommandWidget.dart';
import 'package:delivery/view/component/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Cubit/AppStates.dart';
import '../component/LoadingShimmer.dart';
import '../component/conditional_builder.dart';
import '../component/empty_widget.dart';

class FinishedOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getDeliveryOrders(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // AppCubit cubit = AppCubit.get(context);

          if (AppCubit.get(context).orderModel == null) {
            return VListLoading(
              scroll: Axis.vertical,
            );
          } else
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    'Completed',
                    style: textStyle(
                      context,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    Opacity(
                        opacity: AppCubit.get(context).orderLoading ? 0.5 : 1,
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Flexible(
                              flex: 1,
                              child: ListView(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Container(
                                  //     height: 70.h,
                                  //     width: 500,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(15),
                                  //         color:
                                  //             AppCubit.get(context).themeMode ==
                                  //                     true
                                  //                 ? Colors.grey[800]
                                  //                 : Colors.grey),
                                  //     child: Row(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.center,
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceEvenly,
                                  //       children: [
                                  //         cartItem(
                                  //             'All Orders'.tr(),
                                  //             cubit.allOrder.toString(),
                                  //             context),
                                  //         cartItem(
                                  //             'Finished'.tr(),
                                  //             cubit.finishOrder.toString(),
                                  //             context),
                                  //         cartItem(
                                  //             'Not Finished'.tr(),
                                  //             cubit.notFinishOrder.toString(),
                                  //             context),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  SingleChildScrollView(
                                    child: conditionalBuilder(
                                        condition: AppCubit.get(context)
                                                .orderModel!
                                                .results!
                                                .length >
                                            0,
                                        builder: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              CommandWidget(
                                            screen: 'myOrders',
                                            results: AppCubit.get(context)
                                                .completedOrderModel![index],
                                            orderId: AppCubit.get(context)
                                                .completedOrderModel![index]
                                                .id,
                                            clientName: AppCubit.get(context)
                                                .completedOrderModel![index]
                                                .name,
                                            phone: AppCubit.get(context)
                                                .completedOrderModel![index]
                                                .user!
                                                .phone,
                                            dropOffAddress:
                                                AppCubit.get(context)
                                                    .completedOrderModel![index]
                                                    .address,
                                            notes: AppCubit.get(context)
                                                    .completedOrderModel![index]
                                                    .notes ??
                                                '',
                                            price: AppCubit.get(context)
                                                .completedOrderModel![index]
                                                .total,
                                            location: AppCubit.get(context)
                                                .completedOrderModel![index]
                                                .location,
                                            status: AppCubit.get(context)
                                                .completedOrderModel![index]
                                                .status,
                                          ),
                                          itemCount: AppCubit.get(context)
                                              .completedOrderModel!
                                              .length,
                                        ),
                                        fallback: Center(
                                            child: EmptyWidget(
                                                'There are no orders yet!'))),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    Opacity(
                      opacity: AppCubit.get(context).orderLoading ? 1.0 : 0,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ));
        },
      ),
    );
  }
}
