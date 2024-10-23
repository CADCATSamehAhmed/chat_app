import 'dart:io';
import 'package:chat_app/core/shared_prefences/functions/my_file_picker.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/profile/data/repo/profile_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileStates {}
class ProfileInitialState extends ProfileStates {}
class GetProfileState extends ProfileStates {}
class ChangeUserNameState extends ProfileStates {}
class ChangeUserPhoneState extends ProfileStates {}
class PickedProfileImageSuccessState extends ProfileStates {}
class PickedProfileImageErrorState extends ProfileStates {}
class UpdateProfileState extends ProfileStates {}

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit? _profileCubit;
  ProfileRepo profileRepo = ProfileRepo();
  UserModel userModel = UserModel('uid', 'name', 'email', 'phone', 'image');
  File? pickedImage;
  PlatformFile? file;

  static ProfileCubit get(context) {
    _profileCubit ??= BlocProvider.of(context);
    return _profileCubit!;
  }

  void getUserData() async {
    userModel = (await ProfileRepo.getProfileData())!;
    emit(GetProfileState());
  }

  Future<void> updateProfile(String name,String phone) async {
    await profileRepo.updateProfileData(name,phone,file!);
    emit(UpdateProfileState());
  }

  Future<void> pickProfileImage() async {
    try {
      pickedImage = null;
      pickedImage = await MyFilePicker.pickImage();
      file = MyFilePicker.file;
      emit(PickedProfileImageSuccessState());
    } catch (error) {
      emit(PickedProfileImageErrorState());
    }
  }
}
