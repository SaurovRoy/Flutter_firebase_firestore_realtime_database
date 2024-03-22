import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final bool loading ;
  final String title;
  final VoidCallback onTap;
  const RoundButton({super.key, required  this.title,required this.onTap,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:Container(
        height: 40,
        decoration:  BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child:Center(
          child:loading?const CircularProgressIndicator(color: Colors.white,strokeWidth: 3,):Text(title),
        )

      ) ,
    );
  }
}

