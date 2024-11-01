import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,20,20).w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          elevation: 30,
          iconSize: 30.sp,
          items: items.map<BottomNavigationBarItem>((value) {
            return BottomNavigationBarItem(
              icon: value.icon,
              label: value.label,
              tooltip: value.label,
            );
          }).toList(),
          onTap: onTap,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
final List<BottomNavigationBarItem> items = [
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.message_rounded,
    ),
    label: 'Chats',
  ),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.groups,
    ),
    label: 'Groups',
  ),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.lightbulb,
    ),
    label: 'Status',
  ),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.call_outlined,
    ),
    label: 'Calls',
  ),
];


