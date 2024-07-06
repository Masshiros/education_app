extension StringExtension on String {
  String get obscureEmail {
    final index = indexOf("@");
    var username = substring(0, index);
    final domain = substring(index + 1);

    username = '${username[0]}****${username[username.length - 1]}';
    return '$username@$domain';
  }
}
