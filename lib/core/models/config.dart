class Config {
  const Config(
      {required this.apApiDomain,
      required this.apApiBasePath,
      this.apApiPort,
      this.urlType});

  final String apApiDomain;
  final String apApiBasePath;
  final int? apApiPort;
  final String? urlType;
}
