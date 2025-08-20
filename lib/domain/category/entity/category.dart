class CategoryEntity {
  final String title;
  final String categoryId;
  final String image;

  CategoryEntity({
    required this.title,
    required this.categoryId,
    required this.image,
  });


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryEntity &&
        other.title == title &&
        other.categoryId == categoryId &&
        other.image == image;
  }

  @override
  int get hashCode => title.hashCode ^ categoryId.hashCode ^ image.hashCode;


  @override
  String toString() =>
      'CategoryEntity(title: $title, categoryId: $categoryId, image: $image)';
}
