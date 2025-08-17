import 'package:login_signin/core/data/products_model.dart';

abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class LoadProductEvent extends ProductEvent {
  final int productId;
  LoadProductEvent(this.productId);
}

class AddProductEvent extends ProductEvent {
  final Product product;
  AddProductEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  UpdateProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final Product product;
  DeleteProductEvent(this.product);
}
