class News {
  final String title;
  final String content;
  final String date;

  News({
    required this.title,
    required this.content,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      content: json['content'],
      date: json['date'],
    );
  }
}