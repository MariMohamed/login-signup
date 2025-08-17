import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/remote/api_constants.dart' show ApiConstants;
import 'package:login_signin/core/remote/api_service.dart';
import 'package:login_signin/presentation/features/productlist/controller/product_events.dart';
import 'package:login_signin/presentation/features/productlist/controller/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc({required this.apiService}) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<LoadProductEvent>(_onLoadProduct);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final response = await apiService.get(path: ApiConstants.products);
      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data as List;
        final products = dataList.map((e) => Product.fromJson(e)).toList();
        emit(ProductsLoaded(products));
      } else {
        emit(
          ProductError(
            'Failed to load products: Status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadProduct(
    LoadProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final response = await apiService.get(
        path: '${ApiConstants.products}/${event.productId}',
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        emit(ProductLoaded(Product.fromJson(data)));
      } else {
        emit(
          ProductError(
            'Failed to load product: Status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final response = await apiService.post(
        path: ApiConstants.products,
        data: event.product.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ProductOperationSuccess('Product added successfully'));
        add(LoadProductsEvent()); // Refresh the product list
      } else {
        emit(
          ProductError(
            'Failed to add product: Status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final response = await apiService.update(
        path: '${ApiConstants.products}/${event.product.id}',
        data: event.product.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ProductOperationSuccess('Product updated successfully'));
        add(LoadProductsEvent()); // Refresh the product list
      } else {
        emit(
          ProductError(
            'Failed to update product: Status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final response = await apiService.delete(
        path: '${ApiConstants.products}/${event.product.id}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ProductOperationSuccess('Product deleted successfully'));
        add(LoadProductsEvent()); // Refresh the product list
      } else {
        emit(
          ProductError(
            'Failed to delete product: Status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
