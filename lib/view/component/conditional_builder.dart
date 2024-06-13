

import 'package:flutter/material.dart';

Widget conditionalBuilder({bool? condition = false, builder,Widget? fallback}) {
  if (condition == true) {
    return builder;
  } else {
    return fallback!;
  }
}
