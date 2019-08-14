class UrlUtil {
  static String addBasicAuth(String url, String login, String password) {
    final address = url.split("://");

    if (address.length == 2) {
      final scheme = address[0];
      final domain = address[1];

      return "$scheme://$login:$password@$domain";
    }
    return url;
  }

  static bool hasBasicAuth(String url) => RegExp(r':\/\/.+:.+@').hasMatch(url);
}
