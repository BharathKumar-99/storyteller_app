import 'package:flutter/material.dart';
import 'package:storyteller/constants/list_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/model/story_model.dart';

import '../../constants/image_constnats.dart';
import '../../initilizing/supabase.dart';
import '../../util/ads/interstler_ads.dart';
import '../widgets/story_card.dart';

class IndividualSearchScreen extends StatefulWidget {
  final int id;
  const IndividualSearchScreen({super.key, required this.id});

  @override
  State<IndividualSearchScreen> createState() => _IndividualSearchScreenState();
}

class _IndividualSearchScreenState extends State<IndividualSearchScreen> {
  String title = '';
  List<StoryModel> stories = [];
  bool isLoaded = false;

  @override
  void initState() {
    InterstitialExampleState().loadAd((ad) {
      setState(() {
        isLoaded = true;
      });
      ad.dispose();
    });
    getStories();
    super.initState();
  }

  getStories() async {
    title = ListConstants.tags.entries
        .firstWhere((element) => element.key == widget.id)
        .value;
    await SupaFlow.client.rpc(TableConstants.fetchStories, params: {
      TableConstants.fetchStoriesParam: [widget.id]
    }).then((value) async {
      value.forEach((element) {
        element[TableConstants.tagIds].forEach((tag) {
          stories.add(StoryModel.fromJson(element));
        });
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: stories.isEmpty || !isLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: stories.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 0.7,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                StoryModel story = stories[index];
                return StoryCardWidget(
                    title: story.title ?? "",
                    image: story.pic ?? ImageConstants.errorImage,
                    id: story.id ?? 0);
              }),
    );
  }
}
