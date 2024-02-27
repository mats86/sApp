class SchoolInfo {
  final String schoolName;
  final String websiteUrl;

  const SchoolInfo(
      {this.schoolName = 'wassermenschen',
        this.websiteUrl = 'https://wassermenschen.org/'});

  static const SchoolInfo empty = SchoolInfo();

  static SchoolInfo fromRef(String ref) {
    switch (ref) {
      case 'allgaeu':
        return const SchoolInfo(
            schoolName: 'Schwimmschule Allgäu',
            websiteUrl: 'https://schwimmschule-allgaeu.de/');
      case 'oberschwaben':
        return const SchoolInfo(
            schoolName: 'Schwimmschule Oberschwaben',
            websiteUrl: 'www.wange_schuhle.de');
      case 'unterallgaeu':
        return const SchoolInfo(
            schoolName: 'Schwimmschule Unterallgäu',
            websiteUrl: 'www.wange_schuhle.de');
      default:
        return empty;
    }
  }
}
