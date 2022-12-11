import 'package:flutter/material.dart';
import 'package:medical_app/Models/tab_item.dart';
import 'package:medical_app/config/palette.dart';

class CustomTabBar extends StatelessWidget {

  final List<TabItem> icons;
  final int selectedIndex;
  final Function(int) onTap;
  const CustomTabBar({
    Key? key,
    required this.icons,
    required this.selectedIndex,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Palette.mainColor,
            width: 3.0,
          )
        ),
      ),
      tabs: icons.asMap()
          .map((i, e) => MapEntry(i, Tab(
        icon: Icon(e.icon, color: i == selectedIndex?Palette.mainColor:Colors.grey, size: 24.0,),
        iconMargin: EdgeInsets.only(bottom: 5.0),
        child: Text(e.title!, style: TextStyle(color: i == selectedIndex?Palette.mainColor:Colors.grey, fontSize: 12.0, fontWeight: FontWeight.bold)),
      ))).values.toList(),
      onTap: onTap,
    );
  }
}
