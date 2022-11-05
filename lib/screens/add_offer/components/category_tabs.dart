import 'package:flutter/material.dart';
import 'package:sonar/providers/offers_provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({Key? key, required this.offersProvider, required this.categoryController}) : super(key: key);

  final OffersProvider offersProvider;
  final TextEditingController categoryController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: TabBar(
        isScrollable: true,
        onTap: (int index) {
          categoryController.text = offersProvider.getCategory(index);
        },
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        indicator: RectangularIndicator(
          bottomLeftRadius: 100,
          bottomRightRadius: 100,
          topLeftRadius: 100,
          topRightRadius: 100,
          strokeWidth: 2,
          // verticalPadding: 20,
          paintingStyle: PaintingStyle.stroke,
        ),
        tabs: const [
          Text(
            "Food",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Clothe",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Entertainment",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Travel",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
