import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:storyteller/constants/list_constants.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/initilizing/supabase.dart';
import 'package:storyteller/model/story_model.dart';
import 'package:storyteller/supabase_calls/user.dart';
import 'package:storyteller/util/routes/index.dart';
import '../../helpers/usefull_functions.dart';
import '../../util/routes/routes_constants.dart';

class AddStoryProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController storyController = TextEditingController();

  XFile? selectedImage;
  List<String> selectedTags = [];

  List<String> tags = ListConstants.stringTags;

  Future<void> pickImage() async {
    PermissionStatus status = await Permission.photos.status;

    if (status.isDenied) {
      try {
        status = await Permission.photos.request();
      } catch (e) {
        SupaBaseCalls().uploadError(RouteConstants.addScreen, e.toString());
      }
    }

    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage = image;
        notifyListeners();
      }
    } else if (status.isDenied) {
      showCustomSnackBar(StringConstants.permissionDenied,
          StringConstants.grantPermission, ContentType.failure);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void addStory() async {
    if (selectedImage == null) {
      return showCustomSnackBar(StringConstants.selectImage,
          StringConstants.error, ContentType.failure);
    }
    if (titleController.text.isEmpty) {
      return showCustomSnackBar(StringConstants.enterTitle,
          StringConstants.error, ContentType.failure);
    }
    if (storyController.text.isEmpty) {
      return showCustomSnackBar(StringConstants.enterStory,
          StringConstants.error, ContentType.failure);
    }
    if (selectedTags.isEmpty) {
      return showCustomSnackBar(StringConstants.selectTags,
          StringConstants.error, ContentType.failure);
    }
    isLoading = true;
    notifyListeners();
    try {
      List<String> tagIds = [];
      ListConstants.tags.entries
          .where((ele) => selectedTags.contains(ele.value))
          .forEach((element) {
        tagIds.add(element.key.toString());
      });
      StoryModel story = StoryModel(
          title: titleController.text,
          story: storyController.text,
          userid: SupaFlow.client.auth.currentUser!.id,
          //tags: tagIds,
          approved: false);
      await SupaFlow.client
          .from(TableConstants.stories)
          .insert(story.toJson())
          .select()
          .single()
          .then((value) async {
        StoryModel story = StoryModel.fromJson(value);
        await SupaBaseCalls()
            .uploadPicture(selectedImage!, story.title ?? "", story.id ?? 0)
            .then((pic) async {
          await SupaFlow.client.from(TableConstants.stories).update(
              {TableConstants.pic: pic}).eq(TableConstants.id, story.id ?? 0);
          List<Map<String, dynamic>> temp = [];
          for (var element in tagIds) {
            temp.add({
              TableConstants.storyid: story.id,
              TableConstants.tagId: int.tryParse(element)
            });
          }
          await SupaFlow.client.from(TableConstants.storyTags).insert(temp);
        });
      });

      showCustomSnackBar(StringConstants.postCreated, StringConstants.success,
          ContentType.success);
      isLoading = false;
      ctx?.go(RouteConstants.home);
    } catch (e) {
      return showCustomSnackBar(StringConstants.somethingWentWrong,
          StringConstants.error, ContentType.failure);
    }
  }

  void addSelection(String string) {
    selectedTags.contains(string)
        ? selectedTags.remove(string)
        : selectedTags.add(string);
    notifyListeners();
  }
}
