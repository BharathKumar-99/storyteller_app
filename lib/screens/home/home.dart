// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storyteller/constants/image_constnats.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/screens/home/home_provider.dart';
import 'package:storyteller/screens/widgets/story_card.dart';
import '../../model/story_model.dart';
import '../../util/routes/routes_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider()..getStories(),
          builder: (context, widget) {
            return Consumer<HomeProvider>(builder: (context, data, widgets) {
              return SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringConstants.home,
                              style: Theme.of(context).textTheme.displayMedium),
                          GestureDetector(
                            onTap: () {
                              context.push(RouteConstants.profile);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: FadeInImage.assetNetwork(
                                  placeholder: ImageConstants
                                      .logo, // Local placeholder image
                                  image: data.userModel.pic ??
                                      ImageConstants.errorLogo,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.warning),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //         hintText: StringConstants.search,
                      //         contentPadding:
                      //             const EdgeInsets.symmetric(horizontal: 20),
                      //         enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //           borderSide:
                      //               BorderSide(color: Colors.grey.shade400),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //           borderSide:
                      //               BorderSide(color: Colors.grey.shade400),
                      //         ),
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //           borderSide:
                      //               BorderSide(color: Colors.grey.shade400),
                      //         ),
                      //         prefixIconConstraints: const BoxConstraints(
                      //           maxHeight: 25,
                      //         ),
                      //         prefixIcon: Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 6.0),
                      //           child: SvgPicture.asset(
                      //             'assets/icons/search.svg',
                      //             color: Colors.grey.shade400,
                      //           ),
                      //         )),
                      //   ),
                      // ),
                      if (data.continuedStories.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(StringConstants.continueReading,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.continuedStories.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  StoryModel story =
                                      data.continuedStories[index];
                                  return StoryCardWidget(
                                      title: story.title ?? "",
                                      image: story.pic ??
                                          ImageConstants.errorImage,
                                      id: story.id ?? 0);
                                }),
                          ],
                        ),
                      ListView.builder(
                          itemCount: data.stories.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map<String, List<StoryModel>> stories =
                                data.stories[index];
                            return stories.values.first.isEmpty
                                ? Container()
                                : Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                            '${StringConstants.becauseuLike} ${stories.keys.first}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                        subtitle: Text(StringConstants
                                            .basedOnYourFavorite),
                                      ),
                                      GridView.builder(
                                          itemCount:
                                              stories.values.first.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 300,
                                            childAspectRatio: 0.7,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            StoryModel story =
                                                stories.values.first[index];
                                            return StoryCardWidget(
                                                title: story.title ?? "",
                                                image: story.pic ??
                                                    ImageConstants.errorImage,
                                                id: story.id ?? 0);
                                          }),
                                    ],
                                  );
                          })
                    ],
                  ),
                ),
              ));
            });
          }),
    );
  }
}
