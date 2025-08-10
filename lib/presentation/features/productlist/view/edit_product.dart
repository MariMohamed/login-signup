import 'package:flutter/material.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  EditProduct({super.key, required this.product});
  Product product;
  @override
  State<EditProduct> createState() => _AddProductState();
}

class _AddProductState extends State<EditProduct> {
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
      appBar: AppBar(title: Text(AppStrings.update)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormTemplate(
          enabled: true,
          submitMessage: AppStrings.update,
          onSubmit: () async {
            try {
              // Safe number parsing with fallback values
              final parsedPrice =
                  num.tryParse(price.text) ?? widget.product.price;
              final parsedRating =
                  double.tryParse(rating.text) ??
                  widget.product.rating.values.first;

              // Create the updated product
              final updatedProduct = widget.product.copyWith(
                title: title.text.isNotEmpty
                    ? title.text
                    : widget.product.title,
                price: parsedPrice,
                description: description.text.isNotEmpty
                    ? description.text
                    : widget.product.description,
                category: category.text.isNotEmpty
                    ? category.text
                    : widget.product.category,
                image: image.text.isNotEmpty
                    ? image.text
                    : widget.product.image,
                rating: {
                  "rate": parsedRating,
                  "count": widget.product.rating.values.last,
                }, // Preserve original count
              );

              // Update through provider
              await Provider.of<AppDataProvider>(
                context,
                listen: false,
              ).updateproduct(updatedProduct, context);

              // Show success and close
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product updated successfully')),
                );
                Navigator.pop(context);
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Update failed: ${e.toString()}')),
                );
              }
            }
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
