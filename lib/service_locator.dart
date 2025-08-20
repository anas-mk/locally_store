import 'package:get_it/get_it.dart';
import 'package:locally/data/auth/repository/auth_repository_impl.dart';
import 'package:locally/data/auth/source/auth_firebase_service.dart';
import 'package:locally/data/category/repository/category.dart' as category_data;
import 'package:locally/data/category/source/category_firebase_service.dart';
import 'package:locally/data/order/repository/order.dart';
import 'package:locally/data/order/source/order_firebase_service.dart';
import 'package:locally/data/product/repository/product.dart';
import 'package:locally/data/product/source/product_firebase_service.dart';
import 'package:locally/domain/auth/repository/auth.dart';
import 'package:locally/domain/auth/usecases/get_ages.dart';
import 'package:locally/domain/auth/usecases/get_user.dart';
import 'package:locally/domain/auth/usecases/is_logged_in.dart';
import 'package:locally/domain/auth/usecases/send_password_reset_email.dart';
import 'package:locally/domain/auth/usecases/siginin.dart';
import 'package:locally/domain/auth/usecases/siginup.dart';
import 'package:locally/domain/category/repository/category.dart';
import 'package:locally/domain/category/source/category_firebase_service.dart';
import 'package:locally/domain/category/usecases/get_categories.dart';
import 'package:locally/domain/order/repository/order.dart';
import 'package:locally/domain/order/usecases/add_to_cart.dart';
import 'package:locally/domain/order/usecases/get_cart_products.dart';
import 'package:locally/domain/order/usecases/get_orders.dart';
import 'package:locally/domain/order/usecases/order_registration.dart';
import 'package:locally/domain/order/usecases/remove_cart_product.dart';
import 'package:locally/domain/product/repository/product.dart';
import 'package:locally/domain/product/usecases/add_or_remove_favorite_product.dart';
import 'package:locally/domain/product/usecases/get_favorties_products.dart';
import 'package:locally/domain/product/usecases/get_new_in.dart';
import 'package:locally/domain/product/usecases/get_products_by_category_id.dart';
import 'package:locally/domain/product/usecases/get_products_by_title.dart';
import 'package:locally/domain/product/usecases/get_top_selling.dart';
import 'package:locally/domain/product/usecases/is_favorite.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<CategoryFirebaseService>(
      CategoryFirebaseServiceImpl()
  );


  sl.registerSingleton<ProductFirebaseService>(
      ProductFirebaseServiceImpl()
  );

  sl.registerSingleton<OrderFirebaseService>(
      OrderFirebaseServiceImpl()
  );


  // Repositories
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<CategoryRepository>(
      category_data.CategoryRepositoryImpl(sl<CategoryFirebaseService>())
  );

  sl.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(sl<ProductFirebaseService>()),
  );

  sl.registerSingleton<OrderRepository>(
      OrderRepositoryImpl()
  );


  // Usecases
  sl.registerSingleton<GetCategoriesUseCase>(
      GetCategoriesUseCase(sl<CategoryRepository>())
  );

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<GetAgesUseCase>(
      GetAgesUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );

  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase()
  );

  sl.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );

  sl.registerSingleton<GetTopSellingUseCase>(
      GetTopSellingUseCase()
  );

  sl.registerSingleton<GetNewInUseCase>(
      GetNewInUseCase()
  );

  sl.registerSingleton<GetProductsByCategoryIdUseCase>(
      GetProductsByCategoryIdUseCase()
  );

  sl.registerSingleton<GetProductsByTitleUseCase>(
      GetProductsByTitleUseCase()
  );

  sl.registerSingleton<AddToCartUseCase>(
      AddToCartUseCase()
  );

  sl.registerSingleton<GetCartProductsUseCase>(
      GetCartProductsUseCase()
  );

  sl.registerSingleton<RemoveCartProductUseCase>(
      RemoveCartProductUseCase()
  );

  sl.registerSingleton<OrderRegistrationUseCase>(
      OrderRegistrationUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteProductUseCase>(
      AddOrRemoveFavoriteProductUseCase()
  );

  sl.registerSingleton<IsFavoriteUseCase>(
      IsFavoriteUseCase()
  );

  sl.registerSingleton<GetFavortiesProductsUseCase>(
      GetFavortiesProductsUseCase()
  );

  sl.registerSingleton<GetOrdersUseCase>(
      GetOrdersUseCase()
  );
}
