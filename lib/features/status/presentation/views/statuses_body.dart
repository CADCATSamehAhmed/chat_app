import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:chat_app/features/status/presentation/views/widgets/my_status_row.dart';
import 'package:chat_app/features/status/presentation/views/widgets/status_row.dart';
import 'package:chat_app/features/status/presentation/views/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusesBody extends StatelessWidget {
  const StatusesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<StatusCubit, StatusStates>(
          listener: (context, state) {},
          builder: (context, state) {
            StatusCubit cubit = StatusCubit.get(context);
            return StreamBuilder<List<StatusesModel>>(
              stream: cubit.getAllStatuses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No status'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyStatusRow(
                        lastStatus: cubit.myStatus == null
                            ? null
                            : cubit.myStatus!
                                .statuses[cubit.myStatus!.statuses.length - 1]),
                    if (cubit.recentStatuses.isNotEmpty)
                      const StatusTextRow(text: "Recent updates"),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.recentStatuses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StatusRow(
                          statuses: cubit.recentStatuses[index],
                          isWatched: false,
                          lastStatus: cubit.recentStatuses[index].statuses[
                              cubit.recentStatuses[index].statuses.length - 1],
                        );
                      },
                    ),
                    if (cubit.watchedStatuses.isNotEmpty)
                      const StatusTextRow(text: "Viewed updates"),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.watchedStatuses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StatusRow(
                          statuses: cubit.watchedStatuses[index],
                          isWatched: true,
                          lastStatus: cubit.watchedStatuses[index].statuses[
                              cubit.watchedStatuses[index].statuses.length - 1],
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
