import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyteller/constants/image_constnats.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/screens/widgets/tag_cards.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'add_story_provider.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return ChangeNotifierProvider<AddStoryProvider>(
      create: (context) => AddStoryProvider(),
      child: Consumer<AddStoryProvider>(builder: (context, snapshot, widget) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(StringConstants.createPost,
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      TextField(
                        controller: snapshot.titleController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: StringConstants.title,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Wrap(
                        children: snapshot.selectedTags
                            .map((tag) => tagCards(context, tag))
                            .toList(),
                      ),
                      snapshot.selectedTags.isEmpty
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: height * 0.03,
                            ),
                      DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(20),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        icon: Container(),
                        items: snapshot.tags.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(StringConstants.selectTag),
                        onChanged: (value) {
                          snapshot.addSelection(value.toString());
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextField(
                        minLines: 10,
                        maxLines: 10,
                        controller: snapshot.storyController,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: StringConstants.story,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              snapshot.pickImage();
                            },
                            child: snapshot.selectedImage == null
                                ? Container(
                                    height: height * 0.20,
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                ImageConstants.errorImage)),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  )
                                : Container(
                                    height: height * 0.20,
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                snapshot.selectedImage!.path))),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                          ),
                          SizedBox(
                            height: height * 0.07,
                            width: width * 0.4,
                            child: ElevatedButton(
                              onPressed: () {
                                snapshot.addStory();
                              },
                              child: Text(
                                StringConstants.createPost,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (snapshot.isLoading)
                Center(
                  child: LoadingAnimationWidget.beat(
                    color: Theme.of(context).colorScheme.primary,
                    size: 200,
                  ),
                )
            ],
          ),
        );
      }),
    );
  }
}
