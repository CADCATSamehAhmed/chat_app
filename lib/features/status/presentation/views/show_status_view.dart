import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:chat_app/features/status/presentation/views/widgets/show_status_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/status_cubit.dart';

class ShowStatusView extends StatelessWidget {
  final StatusesModel statuses;
  const ShowStatusView({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatusCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ShowStatusBody(
          statuses: statuses
        ),
      ),
    );
  }
}
