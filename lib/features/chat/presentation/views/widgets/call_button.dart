import "package:flutter/material.dart";
import "package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallInvitationButton extends StatelessWidget {
  final bool isVideo;
  final List<dynamic> partnerIds;
  final List<dynamic> partnerNames;

  const CallInvitationButton(
      {super.key,required this.isVideo, required this.partnerIds, required this.partnerNames});

  @override
  Widget build(BuildContext context) {
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideo,
      resourceID: "zegouikit_call",
      invitees: List.generate(
        partnerIds.length,
        (index) => ZegoUIKitUser(
          id: partnerIds[index],
          name: partnerNames[index],
        ),
      ),
      buttonSize: Size(50.w, 50.w),
      iconSize: Size(40.w, 40.w),
    );
  }
}
