import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyteller/constants/image_constnats.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/model/tags_model.dart';
import 'package:storyteller/screens/story_screen/story_details_provider.dart';

import '../widgets/tag_cards.dart';

class StoryScreen extends StatelessWidget {
  final int storyId;
  const StoryScreen({super.key, required this.storyId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoryDetailsProvider>(
        create: (context) => StoryDetailsProvider()..getStory(storyId),
        child: Consumer<StoryDetailsProvider>(
            builder: (context, snapshot, widget) {
          if (snapshot.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(snapshot.story.title ?? ""),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.8,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.sizeOf(context).height *
                                              0.03,
                                      horizontal:
                                          MediaQuery.sizeOf(context).width *
                                              0.05),
                                  height:
                                      MediaQuery.sizeOf(context).height / 3.1,
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.story.pic ??
                                          ImageConstants.errorImage,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                snapshot.story.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${snapshot.viewCount} ${StringConstants.views}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                  children: snapshot.tag
                                      .map((TagsModel e) =>
                                          tagCards(context, e.name ?? ""))
                                      .toList())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      snapshot.story.story ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Theme.of(context).colorScheme.primary
                            ]),
                        image: const DecorationImage(
                            fit: BoxFit.scaleDown,
                            scale: 3,
                            image: AssetImage(ImageConstants.theEnd))),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height - 110, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
