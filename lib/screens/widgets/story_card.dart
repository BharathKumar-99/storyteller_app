import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storyteller/constants/image_constnats.dart';
import 'package:storyteller/constants/string_constants.dart'; 
import 'package:storyteller/util/routes/routes_constants.dart';

class StoryCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final int id;
  final bool? isApproved;
  final bool? cancelled;

  const StoryCardWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.id,
      this.cancelled,
      this.isApproved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.push(RouteConstants.storyScreen, extra: id);
        },
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -40,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: ImageConstants.logo, // Local placeholder image
                    image: image,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.warning),
                  ),
                ),
              ),
            ),
            if (cancelled == true)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    Text(
                      StringConstants.rejected,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                )),
              ),
            if (isApproved == false && cancelled == false)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning, color: Colors.red),
                    Text(
                      StringConstants.approvalPending,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                )),
              )
          ],
        ),
      ),
    );
  }
}
