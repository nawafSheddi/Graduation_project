import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/offers_provider.dart';
import 'package:sonar/screens/add_offer/components/category_tabs.dart';
import 'package:sonar/screens/offer_screen/components/space.dart';
import 'package:sonar/shared/main_button.dart';
import 'package:sonar/shared/navBar.dart';
import 'package:sonar/shared/text_field.dart';

class AddOffer extends StatelessWidget {
  AddOffer({Key? key}) : super(key: key);
  static const routeName = "/add-offer";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController offerController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController linksController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<OffersProvider>(
          builder: (context, offersProvider, child) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Share Offer",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3),
                    ),
                    const Space(
                      height: 20,
                    ),
                    SizedBox(width: size.width),
                    MainTextField(controller: nameController, hint: "name"),
                    MainTextField(controller: descriptionController, hint: "Company description"),
                    MainTextField(controller: offerController, hint: "Offer like (10% on T-shirts)"),
                    MainTextField(controller: detailsController, hint: "offer details"),
                    MainTextField(controller: durationController, hint: "duration like (for 2 days)"),
                    MainTextField(controller: linksController, hint: "Link for more Info about the offer"),
                    MainTextField(controller: imageController, hint: "Image link"),
                    MainTextField(controller: codeController, hint: "promo code"),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05, top: 16),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Category',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    CategoryTabs(categoryController: categoryController, offersProvider: offersProvider),
                    MainButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          offersProvider.addOffer(
                              name: nameController.text,
                              description: descriptionController.text,
                              offer: offerController.text,
                              category: "",
                              details: detailsController.text,
                              duration: durationController.text,
                              links: linksController.text,
                              image: imageController.text,
                              code: codeController.text);
                        }
                      },
                      title: "Share",
                      isDangerous: false,
                      padding: EdgeInsets.only(top: size.height * 0.05),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
