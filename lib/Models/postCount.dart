class PostCount {
  final String day;
  final int count;

  PostCount({required this.day, required this.count});

  factory PostCount.fromJson(Map<String, dynamic> json) {
    return PostCount(
      day: json['day'] as String,
      count: json['count'] as int,
    );
  }
}
