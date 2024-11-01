import 'package:chat_app/features/chat/data/models/group_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/group/group_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/group/inside_group_body.dart';

class InsideGroupView extends StatelessWidget {
  final GroupModel group;
  const InsideGroupView({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: GroupAppBar(group: group),
        body: InsideGroupBody(group: group,),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
