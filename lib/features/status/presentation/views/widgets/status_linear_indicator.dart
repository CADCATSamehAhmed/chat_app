import 'package:chat_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

class StatusLinearIndicator extends StatelessWidget {
  final int totalSegments;
  final int currentPageIndex;
  final double progress;

  const StatusLinearIndicator(
      {super.key,
      required this.totalSegments,
      required this.currentPageIndex,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 10,
      right: 10,
      child: Row(
        children: List.generate(
          totalSegments,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: LinearProgressIndicator(
                value: index == currentPageIndex
                    ? progress
                    : (index < currentPageIndex ? 1 : 0),
                backgroundColor: Colors.grey.shade300,
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
