import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Image.asset(
            'assets/icons/angle-left.png',
            cacheWidth: Adaptive.w(6).toInt(),
            color: Theme.of(context).colorScheme.scrim,
          ),
        ),
        actions: [
          SizedBox(
            width: Adaptive.w(90),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
