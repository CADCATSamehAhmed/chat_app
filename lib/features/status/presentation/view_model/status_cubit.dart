import 'dart:async';
import 'dart:io';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_file_picker.dart';
import 'package:chat_app/features/status/data/models/status_model.dart';
import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:chat_app/features/status/data/repo/status_repo.dart';
import 'package:chat_app/features/status/presentation/views/widgets/add_new_status_image_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

abstract class StatusStates {}
class StatusInitialState extends StatusStates {}
class PickMediaStatusSuccessState extends StatusStates {}
class PickMediaStatusErrorState extends StatusStates {}
class AddStatusState extends StatusStates {}
class MakeStatusWatchedState extends StatusStates {}

class StatusCubit extends Cubit<StatusStates> {
  StatusCubit() : super(StatusInitialState());
  static StatusCubit? _statusCubit;

  static StatusCubit get(context) {
    _statusCubit ??= BlocProvider.of(context);
    return _statusCubit!;
  }

  StatusRepo statusRepo = StatusRepo();
  StatusesModel? myStatus;

  List<StatusesModel> recentStatuses = [];
  List<StatusesModel> watchedStatuses = [];
  File? pickedMedia;
  PlatformFile? file;

  Stream<List<StatusesModel>> getAllStatuses() {
    recentStatuses = [];
    myStatus = null;
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .asyncMap((snapshot) async {
      List<StatusesModel> statusesList = [];

      for (var doc in snapshot.docs) {
        String userId = doc['uid'];
        String name = doc['name'];
        String image = doc['image'];

        QuerySnapshot statusSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('statuses')
            .orderBy('timestamp', descending: false)
            .get();

        List<StatusModel> statuses = statusSnapshot.docs.map((statusDoc) {
          return StatusModel.fromJson(statusDoc.data() as Map<String, dynamic>);
        }).toList();

        if (statuses.isNotEmpty) {
          StatusesModel statusesModel = StatusesModel(
            statuses: statuses,
            uId: userId,
            name: name,
            image: image,
          );
          if (userId == uid) {
            myStatus = statusesModel;
          } else if (!watchedStatuses.contains(statusesModel)&&watchedStatuses.isNotEmpty) {
          } else {
            recentStatuses.add(statusesModel);
          }
        }
      }
      return statusesList.isNotEmpty ? statusesList : [];
    });
  }

  Future<void> pickMediaStatus() async {
    try {
      pickedMedia = null;
      pickedMedia = await MyFilePicker.pickImage();
      file = MyFilePicker.file;
      emit(PickMediaStatusSuccessState());
      Get.to(() => AddNewStatusImageBody(
        file: pickedMedia!,
      ));
    } catch (error) {
      emit(PickMediaStatusErrorState());
    }
  }

  Future<void> addNewStatus(StatusModel status,bool statusIsMedia) async {
    await statusRepo.addStatus(status, statusIsMedia,media:statusIsMedia?file:null);
    emit(AddStatusState());
  }

  void makeStatusWatched(StatusesModel statusesModel) {
    if (statusesModel.uId != uid && !watchedStatuses.contains(statusesModel)) {
      recentStatuses.remove(statusesModel);
      watchedStatuses.add(statusesModel);
    }
    emit(MakeStatusWatchedState());
  }
}
