enum HomepageStatus {
  post,
  jobs,
  services,
}

extension HomepageExtension on HomepageStatus {
  int get id {
    switch (this) {
      case HomepageStatus.post:
        return 1;
      case HomepageStatus.jobs:
        return 2;
      case HomepageStatus.services:
        return 3;
      default:
        return 0;
    }
  }

  /// The text representation of the status (for API)
  String get text {
    switch (this) {
      case HomepageStatus.post:
        return 'Post';
      case HomepageStatus.jobs:
        return 'Jobs';
      case HomepageStatus.services:
        return 'Services';
    }
  }

  /// The status name (human-readable)
  String get name {
    switch (this) {
      case HomepageStatus.post:
        return 'Post';
      case HomepageStatus.jobs:
        return 'Jobs';
      case HomepageStatus.services:
        return 'Services';
    }
  }
}