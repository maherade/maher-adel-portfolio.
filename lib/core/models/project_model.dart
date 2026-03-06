class ProjectModel {
  final String title;
  final String description;
  final List<String> tech;
  final String category;
  final String status;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? webUrl;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tech,
    required this.category,
    required this.status,
    this.playStoreUrl,
    this.appStoreUrl,
    this.webUrl,
  });
}
