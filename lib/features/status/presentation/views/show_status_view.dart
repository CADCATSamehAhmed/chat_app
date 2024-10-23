import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:chat_app/features/status/presentation/views/widgets/show_status_body.dart';
import 'package:flutter/material.dart';

class ShowStatusView extends StatelessWidget {
  final StatusesModel statuses;
  const ShowStatusView({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGroundColor,
      body: ShowStatusBody(
        statuses: statuses
      ),
    );
  }
}
