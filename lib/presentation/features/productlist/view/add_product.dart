import 'package:flutter/material.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController rating = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    return CustomScaffold(
      appBar: AppBar(title: Text(AppStrings.addProduct)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormTemplate(
          enabled: true,
          submitMessage: AppStrings.addProduct,
          onSubmit: () async {
            final product = Product(
              id: appData.products.length + 1,
              title: title.text,
              price: num.parse(price.text),
              description: description.text,
              category: category.text,
              image: image.text,
              rating: {"rate": double.parse(rating.text), "count": 0},
            );

            await Provider.of<AppDataProvider>(
              context,
              listen: false,
            ).addproduct(product, context);
            Navigator.pop(context);
          },
          children: [
            AppTextField(
              controller: title,
              onChange: (v) {
                setState(() {});
              },
              hint: AppStrings.title,
              onSaved: (p0) {},
            ),
            AppTextField(
              hint: AppStrings.price,
              onSaved: (value) {},
              controller: price,
              onChange: (value) {
                setState(() {});
              },
            ),
            AppTextField(
              hint: AppStrings.description,
              onSaved: (value) {},
              controller: description,
              onChange: (value) {
                setState(() {});
              },
            ),
            AppTextField(
              hint: AppStrings.category,
              onSaved: (value) {},
              controller: category,
              onChange: (value) {
                setState(() {});
              },
            ),
            AppTextField(
              hint: AppStrings.image,
              onSaved: (value) {},
              controller: image,
              onChange: (value) {
                setState(() {});
              },
            ),
            AppTextField(
              hint: AppStrings.rating,
              onSaved: (value) {},
              controller: rating,
              onChange: (value) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
