import 'package:get/get.dart';

class AboutHighlight {
  final String title;
  final String detail;
  const AboutHighlight(this.title, this.detail);
}

class AboutViewModel extends GetxController {
  final List<AboutHighlight> highlights = const [
    AboutHighlight(
      'Ships to production',
      'Production quality over demos — built for real users, not just prototypes.',
    ),
    AboutHighlight(
      'Full-stack ownership',
      'From Flutter and React Native clients to ASP.NET Core Web APIs and Angular dashboards.',
    ),
    AboutHighlight(
      'AI-enabled features',
      'Hands-on work integrating AI-powered features and intelligent automation.',
    ),
    AboutHighlight(
      'NDA-respecting discipline',
      'Enterprise releases handled with care for client confidentiality.',
    ),
  ];
}
