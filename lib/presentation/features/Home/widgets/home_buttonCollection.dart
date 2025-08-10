import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/widget/app_cardGrid.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Buttoncollection extends StatefulWidget {
  const Buttoncollection({super.key});

  @override
  State<Buttoncollection> createState() => _ButtoncollectionState();
}

class _ButtoncollectionState extends State<Buttoncollection> {
  String? selectedCatagory = null;
  late bool isselected = false;
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context, listen: false);
    Set<String> uniqueCategories = appData.products
        .map((product) => product.category) // Extract categories
        .where((category) => category != null) // Filter out nulls
        .toSet();

    List<String> uniqueCategoryList = uniqueCategories.toList();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 32,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleSwitch(
                minWidth: 100.0,
                initialLabelIndex: isselected
                    ? uniqueCategoryList.indexOf(selectedCatagory!) + 1
                    : 0,
                activeBgColor: [AppColors.container],
                inactiveBgColor: AppColors.white,
                activeFgColor: AppColors.black,
                cornerRadius: 20,
                radiusStyle: true,
                totalSwitches: uniqueCategoryList.length + 1,
                labels: ['All', ...uniqueCategoryList],
                onToggle: (index) {
                  if (index == 0) {
                    setState(() {
                      selectedCatagory = null;
                      isselected = false;
                    });
                  } else {
                    setState(() {
                      selectedCatagory = uniqueCategoryList[index! - 1];
                      isselected = true;
                    });
                  }
                },
              ),
            ),
          ),
          CardGrid(
            products: isselected
                ? appData.products
                      .where((product) => product.category == selectedCatagory)
                      .toList()
                : appData.products,
          ),
        ],
      ),
    );
  }
}
