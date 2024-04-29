import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class ProfileAssetImage extends StatelessWidget {
  final String pathImage;
  final Function() event;
  const ProfileAssetImage({
    super.key,
    required this.pathImage,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 55,
      backgroundColor: Theme.of(context).colorScheme.scrim,
      child: Stack(
        children: [
          CircleAvatar(
            minRadius: 50,
            maxRadius: 50,
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Image(
              image: AssetImage(pathImage),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            height: 30,
            width: 30,
            child: InkWell(
              onTap: () => event(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.scrim,
                ),
                child: const Center(
                  child: Image(
                    image: AssetImage('assets/icons/camera-viewfinder.png'),
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileNetworkImage extends StatelessWidget {
  final String pathImage;
  const ProfileNetworkImage({super.key, required this.pathImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 50,
      maxRadius: 50,
      backgroundColor: Theme.of(context).colorScheme.background,
      backgroundImage: NetworkImage(pathImage),
    );
  }
}

class ProfileAssets extends StatelessWidget {
  final String pathImage;
  const ProfileAssets({super.key, required this.pathImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 50,
      maxRadius: 50,
      backgroundColor: Theme.of(context).colorScheme.background,
      backgroundImage: AssetImage('assets/icons/${pathImage}'),
    );
  }
}

class ProfileBase64 extends StatelessWidget {
  final String base64Image;
  final Function() event;
  const ProfileBase64({
    super.key,
    required this.base64Image,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(base64Image);

    return Center(
      child: SizedBox(
        height: 120,
        width: 120,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircleAvatar(
              minRadius: 50,
              maxRadius: 50,
              backgroundColor: Theme.of(context).colorScheme.background,
              backgroundImage: MemoryImage(bytes),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              height: 30,
              width: 30,
              child: InkWell(
                onTap: () => event(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.scrim,
                  ),
                  child: const Center(
                    child: Image(
                      image: AssetImage('assets/icons/camera-viewfinder.png'),
                      fit: BoxFit.cover,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
