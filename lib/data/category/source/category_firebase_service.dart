// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
//
// abstract class CategoryFirebaseService {
//
//   Future<Either> getCategories();
// }
//
// class CategoryFirebaseServiceImpl extends CategoryFirebaseService {
//
//   @override
//   Future < Either > getCategories() async {
//     try {
//       var categories = await FirebaseFirestore.instance.collection('Categories').get();
//       return Right(
//         categories.docs.map((e) => e.data()).toList()
//       );
//     } catch (e) {
//       return const Left(
//         'Please try again'
//       );
//     }
//   }
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:locally/domain/category/source/category_firebase_service.dart';

class CategoryFirebaseServiceImpl implements CategoryFirebaseService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection("Categories").get();

      final data = snapshot.docs.map((e) => e.data()).toList();

      return Right(data);
    } catch (e) {

      return Left("Failed to load categories");
    }
  }

}


