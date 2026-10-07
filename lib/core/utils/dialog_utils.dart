import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  static void showingloading({required BuildContext context,required String loadingMessage}){
    showDialog(context:context,
    barrierDismissible: false,
    builder: (context)=>AlertDialog(
      content: Row(
        //تاكد
        spacing: 15.sw,
        children: [
          CircularProgressIndicator(
            color: Colors.grey,
          ),
          Text(loadingMessage,style: TextStyle(color: Colors.pink),)
        ],
      ),
    )
    );
  }
}