import 'package:flutter/material.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_drawer.dart';
import 'package:login_signin/presentation/widget/app_cardGrid.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    return appData.isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScaffold(
            drawer: HomeDrawer(),
            implyleading: true,
            body: CardGrid(products: appData.products),
          );
  }
}
