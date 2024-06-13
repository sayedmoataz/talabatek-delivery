import 'package:delivery/view/component/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giff_dialog/giff_dialog.dart';

import '../../bloc/Cubit/AppCubit.dart';


ShowDialog({context,required gif,required title,required  description,required  sharedKey,
  String? okString ,String? canString, VoidCallback? okButton,VoidCallback? canButton,
  required bool okBut}){
  return showDialog(
    context: context,
    builder: (_) => AssetGiffDialog(
      image: Image.asset(gif,alignment: Alignment.center,fit: BoxFit.cover,),
      title: Text("${title}",style: textStyle(
        context,
        size: 16.sp,
        fontWeight: FontWeight.w600,

      ),textAlign: TextAlign.center,),
      description: Text(
        "${description}",style:textStyle(
        context,

      ),textAlign: TextAlign.center
        ,),
      buttonCancelColor: Colors.red,
      buttonOkColor: AppCubit.get(context).primaryColor,
      buttonOkText: Text(okString!,style: textStyle(
        context,
        fontWeight: FontWeight.w600,
        color: Colors.white,

      ),),
      buttonCancelText: Text(canString!,style: textStyle(
        context,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),),
      buttonRadius: 5,
      cornerRadius: 25,
      onOkButtonPressed: okButton,
      onCancelButtonPressed: canButton,
      entryAnimation: EntryAnimation.bottomRight,
      onlyOkButton: okBut,
    ),
  );
}