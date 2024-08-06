// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/util/routes/routes_constants.dart';

import '../../initilizing/supabase.dart';
import '../../model/tags_model.dart';
import '../widgets/tag_cards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 25,
                        ),
                        hintText: StringConstants.search,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                            color: Colors.grey.shade400,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(StringConstants.browseCategories,
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: height * 0.02,
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
                        context.push(RouteConstants.individualSearch,
                            extra: tags[index].id);
                      },
                      child: tagCard(tags[index].name ?? "",
                          tags[index].image ?? "", tags[index].id ?? 0)),
                  itemCount: tags.length,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
