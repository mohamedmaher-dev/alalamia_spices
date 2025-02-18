
class Version {
  final String? androidVersion, iosVersion,isoImportance, androidImportance, androidUrl, isoUrl;
  Version(
      {this.iosVersion,
        this.androidVersion,
        this.isoImportance,
        this.androidImportance,
        this.androidUrl,
        this.isoUrl,
      });
  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      iosVersion: json["iso_version"],
      androidVersion: json["android_version"].toString(),
      isoImportance: json["iso_importance"].toString(),
      androidImportance: json["android_importance"].toString(),
      androidUrl: json["android_url"],
      isoUrl: json["iso_url"],
    );
  }
}