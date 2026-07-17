class Store {
  final String id;
  final String name;
  final double rating;
  final int reviewsCount;
  final String category;
  final double distanceKm;
  final int points;
  final int totalItems;
  final String imageUrl;
  final List<String> tags;
  final bool isVerified;
  final bool isLocked;

  const Store({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.category,
    required this.distanceKm,
    required this.points,
    required this.totalItems,
    required this.imageUrl,
    required this.tags,
    this.isVerified = true,
    this.isLocked = false,
  });
}
