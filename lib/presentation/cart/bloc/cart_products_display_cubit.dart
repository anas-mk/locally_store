import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/domain/order/entities/product_ordered.dart';
import 'package:locally/domain/order/usecases/get_cart_products.dart';
import 'package:locally/domain/order/usecases/remove_cart_product.dart';
import 'package:locally/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:locally/service_locator.dart' show sl;

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit() : super(CartProductsLoading());

  Future<void> displayCartProducts() async {
    emit(CartProductsLoading());
    var returnedData = await sl<GetCartProductsUseCase>().call();

    returnedData.fold(
          (error) {
        emit(LoadCartProductsFailure(errorMessage: error));
      },
          (data) {
        emit(CartProductsLoaded(products: data));
      },
    );
  }

  Future<void> removeProduct(ProductOrderedEntity product) async {
    emit(CartProductsLoading());
    var returnedData = await sl<RemoveCartProductUseCase>().call(
      params: product.id,
    );

    returnedData.fold(
          (error) {
        emit(LoadCartProductsFailure(errorMessage: error));
      },
          (data) {
        displayCartProducts();
      },
    );
  }

}
