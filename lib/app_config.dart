class AppConfig {
  static const String baseUrl = "http://10.0.2.2:3000";

  static String? resolveImageUrl(String? imagePath) {
    final value = imagePath?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    return '$baseUrl${value.startsWith('/') ? '' : '/'}$value';
  }
}