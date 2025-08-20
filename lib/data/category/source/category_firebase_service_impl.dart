import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:locally/domain/category/source/category_firebase_service.dart';

class CategoryFirebaseServiceImpl implements CategoryFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getCategories() async {
    try {
      final snapshot = await _firestore.collection('Categories').get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

