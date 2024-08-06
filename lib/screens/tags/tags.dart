import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storyteller/constants/keys_constants.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/helpers/shared_preferences.dart';
import 'package:storyteller/helpers/usefull_functions.dart';
import 'package:storyteller/initilizing/supabase.dart';
import 'package:storyteller/model/tags_model.dart';
import 'package:storyteller/theme/pallet.dart';
import 'package:storyteller/util/routes/index.dart';
import 'package:storyteller/util/routes/routes_constants.dart';

import '../../constants/app_constants.dart';
import '../../supabase_calls/user.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  List<TagsModel> tags = [];
  List<int> selectedtags = [];

  @override
  void initState() {
    super.initState();

    getTags();
  }

  getTags() async {
    await SupaFlow.client.from(TableConstants.tags).select('*').then((value) {
      for (var element in value) {
        tags.add(TagsModel.fromJson(element));
      }
      setState(() {});
    });
  }

  void addtags() async {
    if (selectedtags.length < 3) {
      return showCustomSnackBar(StringConstants.ohSnap,
          StringConstants.selectTagsAtleastThree, ContentType.failure);
    }
    try {
      var data = [];
      for (var element in tags) {
        data.add({
          TableConstants.userid: AppConstants().userId,
          TableConstants.tagId: element.id ?? 0
        });
      }
      await SupaFlow.client.from(TableConstants.usersTag).insert(data);

      SharedPreferencesUtil.setStringList(
          KeyConstants.tags,
          tags
              .where((tag) => selectedtags.contains(tag.id))
              .map((tag) => tag.name as String)
              .toList());

      showCustomSnackBar(
          StringConstants.great, StringConstants.thanks, ContentType.success);
      ctx!.go(RouteConstants.home);
    } catch (e) {
      SupaBaseCalls().uploadError(RouteConstants.tagScreen, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = AppConstants().getWidth(context);
    double height = AppConstants().getHeight(context);

    tagCard(String name, String url, int id) => Container(
        width: 155,
        height: 56,
        decoration: BoxDecoration(
            color: const Color(0xff7AC8B1),
            border: Border.all(
                width: 2,
                style: BorderStyle.solid,
                color: selectedtags.contains(id)
                    ? ColorPallet.primary
                    : const Color.fromARGB(6, 122, 200, 177)),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                child: Image.network(url))
          ],
        ));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.10,
                ),
                Text(
                  '${StringConstants.hi} ${AppConstants().userName}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  StringConstants.chooseTags,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: width * 0.6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (!selectedtags.contains(tags[index].id)) {
                          selectedtags.add(tags[index].id!);
                        } else {
                          selectedtags.remove(tags[index].id!);
                        }
                        setState(() {});
                      },
                      child: tagCard(tags[index].name ?? "",
                          tags[index].image ?? "", tags[index].id ?? 0)),
                  itemCount: tags.length,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      addtags();
                    },
                    child: const Text(StringConstants.addGenres)),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
