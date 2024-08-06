import 'package:flutter/material.dart';
import 'package:storyteller/util/routes/index.dart';

import '../../constants/image_constnats.dart';

Card tagCards(BuildContext context, String e) {
  return Card(
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        e,
        maxLines: 1,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
  );
}

Container tagCard(String name, String url, int id) => Container(
    width: 155,
    height: 56,
    decoration: BoxDecoration(
        color: const Color(0xff7AC8B1),
        border: Border.all(
            width: 2,
            style: BorderStyle.solid,
            color: const Color.fromARGB(6, 122, 200, 177)),
        borderRadius: BorderRadius.circular(5)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: Theme.of(ctx!)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          child: FadeInImage.assetNetwork(
            placeholder: ImageConstants.logo,
            image: url,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.warning),
          ),
        )
      ],
    ));
