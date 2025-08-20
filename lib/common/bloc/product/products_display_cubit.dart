import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/product/products_display_state.dart';
import 'package:locally/core/usecase/usecase.dart';

class ProductsDisplayCubit extends Cubit<ProductsDisplayState> {
  final UseCase useCase;
  ProductsDisplayCubit({required this.useCase}) : super(ProductsInitialState());

  void displayProducts({dynamic params}) async {
    emit(ProductsLoading());
    var returnedData = await useCase.call(params: params);
    returnedData.fold(
      (error) {
        emit(LoadProductsFailure(message: 'Something went wrong'));
      },
      (data) {
        emit(ProductsLoaded(products: data));
      },
    );
  }

  void displayInitial() {
    emit(ProductsInitialState());
  }
}
