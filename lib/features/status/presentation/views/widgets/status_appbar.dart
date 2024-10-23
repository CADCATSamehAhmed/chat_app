import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:flutter/material.dart';

class StatusAppbar extends StatelessWidget {
  final StatusesModel statuses;
  final String statusDate;
  const StatusAppbar({super.key, required this.statuses, required this.statusDate});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 10,
      right: 10,
      child: Row(
        spacing: 11,
        children: [
          IconButton(
              onPressed: () {
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              )),
          CircleAvatar(
            radius: screenWidth * .07,
            foregroundImage: CachedNetworkImageProvider(statuses.image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              Text(
                statuses.name,
                style: Fonts.font18.copyWith(
                    color: Colors.white, decoration: TextDecoration.none),
              ),
              Text(
                statusDate,
                style: Fonts.font14.copyWith(
                    color: Colors.grey.shade400,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}