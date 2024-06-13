import 'package:flutter/material.dart';

import '../../bloc/Cubit/AppCubit.dart';

class CustomSideDrawerRowItem extends StatelessWidget {
  const CustomSideDrawerRowItem({
    required this.screenSize,
    this.title,
    this.destinationScreen,
    this.icon,
    this.colorIcon,
    this.callback,
    this.isForLogout = false,
  });

  final Size? screenSize;
  final String? title;
  final String? destinationScreen;
  final IconData? icon;
  final Color? colorIcon;
  final VoidCallback? callback;
  final isForLogout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:callback ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: AppCubit.get(context).themeMode == true ? Colors.grey[800]: Colors.grey[200],
                ),
                child: Icon(
                  icon,
                  color: colorIcon ?? null,
                  size: 26,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Visibility(
            visible: !isForLogout,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
