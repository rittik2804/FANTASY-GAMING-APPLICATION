import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_number_game/constant/constant.dart';

CommonToast({required context ,required title ,required bool alignCenter}){
  showToast(title,
    backgroundColor: primaryColor,
    textStyle: const TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 12),
    context: context,
    alignment: alignCenter ? Alignment.center:Alignment.topCenter,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    borderRadius:const BorderRadius.all(Radius.circular(8)),
    textPadding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 7),
    position:alignCenter? StyledToastPosition.center : StyledToastPosition.top,
    animDuration:const Duration(seconds: 1),
    duration:const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}