import 'base.dart';

class ChatBase extends Model {
  String avatar;
  String title;
  String nameIndex;
  String sortIndex;
  ChatBase({
    required this.title,
    required this.avatar,
    String? nameIndex = '',
  })  : nameIndex = nameIndex ?? title[0].toUpperCase(),
        sortIndex = getSortIndex(nameIndex ?? title[0].toUpperCase());

  static String getSortIndex(String nameIndex) {
    if (nameIndex.isEmpty ||
        ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
            .contains(nameIndex)) {
      return '☆';
    } else if (nameIndex.codeUnitAt(0) < 'A'.codeUnitAt(0) ||
        nameIndex.codeUnitAt(0) > 'Z'.codeUnitAt(0)) {
      return '#';
    }
    return nameIndex;
  }

  @override
  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'title': title,
        'nameIndex': nameIndex,
        'sortIndex': sortIndex,
      };
}
