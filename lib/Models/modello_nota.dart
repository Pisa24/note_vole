
class Nota {
  Nota({
  required this.title,
  required this.content,
  required this.contentJson,
  required this.dataCreazione,
  required this.dataModifica,
  required this.tags,
  });
  
  final String? title;
  final String? content;
  final String contentJson;
  final int dataCreazione;
  final int dataModifica;
  final List<String>? tags;
}