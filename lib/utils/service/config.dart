import 'package:smartnote/core/models/config.dart';

const prodServer = Config(
    apApiDomain: '', apApiPort: null, apApiBasePath: '', urlType: "prod");

const configDevLocal = Config(
  apApiDomain: 'localhost',
  apApiPort: 55525,
  apApiBasePath: 'api',
);

const betaServer = Config(
    apApiDomain: 'http://103.192.157.58:4006',
    apApiPort: null,
    apApiBasePath: 'api',
    urlType: "beta");
