import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/screens/profile/profile_provider.dart';
import 'package:storyteller/screens/widgets/tag_cards.dart';

import '../../constants/image_constnats.dart';
import '../../model/story_model.dart';
import '../widgets/story_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider()..getUserDetails(),
      child: Consumer<ProfileProvider>(
        builder: (context, provider, widget) {
          return Scaffold(
            body: provider.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (builder) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      StringConstants.changeProfilePicDetails,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        child: Text(StringConstants.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          provider.pickImage();
                                          context.pop();
                                        },
                                        child: Text(StringConstants.ok),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: provider.userModel.pic?.isEmpty ?? true
                                  ? FadeInImage.assetNetwork(
                                      placeholder: ImageConstants.logo,
                                      image: provider.userModel.pic ?? "",
                                      fit: BoxFit.fill,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              const SizedBox(
                                                  height: 200,
                                                  child: Icon(Icons.warning)),
                                    )
                                  : FadeInImage.assetNetwork(
                                      placeholder: ImageConstants.logo,
                                      image: provider.userModel.pic ?? "",
                                      fit: BoxFit.fill,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              const SizedBox(
                                        height: 250,
                                        child: Icon(Icons.wallet),
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.8)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${provider.userModel.userName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      '${provider.userModel.email}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.02),
                              Text(StringConstants.interests,
                                  style:
                                      Theme.of(context).textTheme.titleLarge!),
                              SizedBox(height: height * 0.02),
                              Wrap(
                                children: [
                                  ...provider.tags.map(
                                    (e) => tagCards(context, e.name ?? ""),
                                  )
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              Text(StringConstants.stories,
                                  style:
                                      Theme.of(context).textTheme.titleLarge!),
                              SizedBox(height: height * 0.02),
                              Card(
                                elevation: 2,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: provider.stories.isEmpty
                                      ? Container(
                                          padding: const EdgeInsets.all(20.0),
                                          child: const Center(
                                            child: Text(
                                                StringConstants.noStrories),
                                          ),
                                        )
                                      : GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: provider.stories.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150,
                                            childAspectRatio: 0.7,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            StoryModel story =
                                                provider.stories[index];
                                            return StoryCardWidget(
                                                title: story.title ?? "",
                                                image: story.pic ??
                                                    ImageConstants.errorImage,
                                                id: story.id ?? 0);
                                          }),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.white24),
                                      )),
                                  onPressed: () {
                                    provider.logout();
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 10),
                                      Text(StringConstants.logOut),
                                    ],
                                  )),
                              SizedBox(height: height * 0.02),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
