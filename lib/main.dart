import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/db_manager/pages/db_fix_date/view/db_fix_date_page.dart';
import 'package:swim_generator_app/db_manager/pages/db_swim_course/view/db_swim_course_page.dart';
import 'package:swim_generator_app/db_manager/view/db_manager_page.dart';
import 'package:swim_generator_app/swim_generator/models/school_info.dart';
import 'package:swim_generator_app/swim_generator/swim_generator.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_stepper.dart';
import 'auth/pages/login/view/login_page.dart';
import 'models/special_feature_mode.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy(); // Setzt die URL-Strategie auf Path-basiert um
  // final HttpLink httpLink = HttpLink('https://localhost:7188/graphql');
  final HttpLink httpLink = HttpLink(
      'https://backend.brave-tu.194-164-56-243.plesk.page:5051/graphql');

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );
  // WebViewPlatform.instance = WebWebViewPlatform();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(graphQLClient: client.value));
}

class MyApp extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const MyApp({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(graphQLClient),
      child: AppView(
        graphQLClient: graphQLClient,
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const AppView({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/codeKidsCourse?code=1711895887-U5ZB0KA5',
      initialRoute: '/',
      // /db_fix_date?ref=50&code=40    '/?ref=10&code=10'
      onGenerateRoute: _generateRoute,
      debugShowCheckedModeBanner: false,
      // theme: FlexThemeData.light(
      //   scheme: FlexScheme.flutterDash,
      //   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      //   blendLevel: 7,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 10,
      //     blendOnColors: false,
      //     useTextTheme: true,
      //     alignedDropdown: true,
      //     useInputDecoratorThemeInDialogs: true,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   useMaterial3: false,
      //   // To use the Playground font, add GoogleFonts package and uncomment
      //   // fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      // darkTheme: FlexThemeData.dark(
      //   scheme: FlexScheme.flutterDash,
      //   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      //   blendLevel: 13,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 20,
      //     useTextTheme: true,
      //     alignedDropdown: true,
      //     useInputDecoratorThemeInDialogs: true,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   useMaterial3: false,
      //   // To use the Playground font, add GoogleFonts package and uncomment
      //   // fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.light,
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return "";
    return text[0].toUpperCase() + text.substring(1);
  }

  String enumName(SpecialFeatureMode mode) {
    return capitalize(mode.toString().split('.').last);
  }

  Route _generateRoute(RouteSettings settings) {
    Widget page;
    SpecialFeatureMode mode;
    String title = 'BUCHUNGS-TOOL';
    int swimCourseID = 0;
    bool isDirectLinks = true;
    bool isCodeLinks = false;
    String? code = '';
    String? ref = '';

    Uri uri = Uri.parse(settings.name!);
    ref = uri.queryParameters['ref'];

    switch (uri.path) {
      case '/':
        mode = SpecialFeatureMode.disabled;
        title = 'KURSFINDER';
        isDirectLinks = false;
        break;
      case '/minis':
        mode = SpecialFeatureMode.minis;
        swimCourseID = SpecialFeatureMode.minis.index;
        break;
      case '/modul0':
        mode = SpecialFeatureMode.modul0;
        swimCourseID = SpecialFeatureMode.modul0.index;
        break;
      case '/schnupper_modul':
        mode = SpecialFeatureMode.schnupperModul;
        swimCourseID = SpecialFeatureMode.schnupperModul.index;
        break;
      case '/basic_3x3':
        mode = SpecialFeatureMode.basic_3x3;
        swimCourseID = SpecialFeatureMode.basic_3x3.index;
        break;
      case '/seepferdchen_ferien_pfingsten':
        mode = SpecialFeatureMode.seepferdchenFerienPfingsten;
        swimCourseID = SpecialFeatureMode.seepferdchenFerienPfingsten.index;
        break;
      case '/seepferdchen_ferien_sommer':
        mode = SpecialFeatureMode.seepferdchenFerienSommer;
        swimCourseID = SpecialFeatureMode.seepferdchenFerienSommer.index;
        break;
      case '/better_swim':
        mode = SpecialFeatureMode.betterSwim;
        swimCourseID = SpecialFeatureMode.betterSwim.index;
        break;
      case '/better_swim2':
        mode = SpecialFeatureMode.betterSwim2;
        swimCourseID = SpecialFeatureMode.betterSwim2.index;
        break;
      case '/summer_class':
        mode = SpecialFeatureMode.summerClass;
        swimCourseID = SpecialFeatureMode.summerClass.index;
        break;
      case '/privatkurs_kind':
        mode = SpecialFeatureMode.privatkursKind;
        swimCourseID = SpecialFeatureMode.privatkursKind.index;
        break;
      case '/privatkurs_erwachsen':
        mode = SpecialFeatureMode.privatkursErwachsen;
        swimCourseID = SpecialFeatureMode.privatkursErwachsen.index;
        break;
      case '/privatkurs_kind2':
        mode = SpecialFeatureMode.privatkursKind2;
        swimCourseID = SpecialFeatureMode.privatkursKind2.index;
        break;
      case '/privatkurs_erwachsen2':
        mode = SpecialFeatureMode.privatkursErwachsen2;
        swimCourseID = SpecialFeatureMode.privatkursErwachsen2.index;
        break;
      case '/freundes3_kurs':
        mode = SpecialFeatureMode.freundes3Kurs;
        swimCourseID = SpecialFeatureMode.freundes3Kurs.index;
        break;
      case '/freundes3_kurs2':
        mode = SpecialFeatureMode.freundes3Kurs2;
        swimCourseID = SpecialFeatureMode.freundes3Kurs2.index;
        break;
      case '/eltern_kind_kurs':
        mode = SpecialFeatureMode.elternKindKurs;
        swimCourseID = SpecialFeatureMode.elternKindKurs.index;
        break;
      case '/eltern_lehren_swim':
        mode = SpecialFeatureMode.elternLehrenSwim;
        swimCourseID = SpecialFeatureMode.elternLehrenSwim.index;
        break;
      case '/codeKidsCourse':
        mode = SpecialFeatureMode.codeKidsCourse;
        isDirectLinks = false;
        isCodeLinks = true;
        code = uri.queryParameters['code'];
        break;
      case '/codeAdultsCourse':
        mode = SpecialFeatureMode.codeAdultsCourse;
        isDirectLinks = true;
        code = uri.queryParameters['code'];
        break;
      case '/db':
        return MaterialPageRoute(
            builder: (context) => DbManagerPage(graphQLClient: graphQLClient));
      case '/db_swim_course':
        return MaterialPageRoute(
            builder: (context) => DbSwimCoursePage(
                  graphQLClient: graphQLClient,
                ));
      case '/db_fix_date':
        return MaterialPageRoute(
            builder: (context) => DbFixDatePage(
                  graphQLClient: graphQLClient,
                ));
      case '/login':
        return MaterialPageRoute(
            builder: (context) => LoginPage(
                  graphQLClient: graphQLClient,
                ));
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => MyHomePage(
            graphQLClient: graphQLClient,
            title: title,
            specialFeatureMode: SpecialFeatureMode.disabled,
            swimCourseID: 0,
            isDirectLinks: false,
            isCodeLinks: false,
            schoolInfo: SchoolInfo.fromRef(ref ?? ''),
          ),
        );
    }

    page = MyHomePage(
      graphQLClient: graphQLClient,
      title: title,
      specialFeatureMode: mode,
      swimCourseID: swimCourseID,
      isDirectLinks: isDirectLinks,
      isCodeLinks: isCodeLinks,
      code: code!,
      schoolInfo: SchoolInfo.fromRef(ref ?? ''),
    );

    return MaterialPageRoute(builder: (_) => page);
  }
}

class MyHomePage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final String title;
  final SpecialFeatureMode specialFeatureMode;
  final List<StepPage> order;
  final int swimCourseID;
  final bool isDirectLinks;
  final bool isCodeLinks;
  final String code;
  final SchoolInfo schoolInfo;

  MyHomePage({
    super.key,
    required this.graphQLClient,
    this.title = 'Schwimmgenerator',
    this.specialFeatureMode = SpecialFeatureMode.disabled,
    this.swimCourseID = 0,
    this.isDirectLinks = true,
    this.isCodeLinks = false,
    this.code = '',
    this.schoolInfo = const SchoolInfo(),
  }) : order = _generateOrder(specialFeatureMode);

  static List<StepPage> _generateOrder(SpecialFeatureMode mode) {
    switch (mode) {
      case SpecialFeatureMode.codeKidsCourse:
        return [
          StepPage.kindPersonalInfo,
          StepPage.personalInfo,
          StepPage.result,
        ];
      case SpecialFeatureMode.codeAdultsCourse:
        return [
          StepPage.swimLevel,
          StepPage.swimSeason,
          StepPage.personalInfo,
          StepPage.result
        ];

      case SpecialFeatureMode.minis:
      case SpecialFeatureMode.modul0:
      case SpecialFeatureMode.schnupperModul:
      case SpecialFeatureMode.basic_3x3:
      case SpecialFeatureMode.seepferdchenFerienPfingsten:
      case SpecialFeatureMode.seepferdchenFerienSommer:
      case SpecialFeatureMode.betterSwim:
      case SpecialFeatureMode.betterSwim2:
      case SpecialFeatureMode.summerClass:
      case SpecialFeatureMode.privatkursKind:
      case SpecialFeatureMode.privatkursKind2:
      case SpecialFeatureMode.freundes3Kurs:
      case SpecialFeatureMode.freundes3Kurs2:
      case SpecialFeatureMode.elternKindKurs:
      case SpecialFeatureMode.elternLehrenSwim:
        return [
          StepPage.swimSeason,
          StepPage.birthDay,
          StepPage.swimPool,
          StepPage.dateSelection,
          StepPage.kindPersonalInfo,
          StepPage.personalInfo,
          StepPage.result,
        ];
      case SpecialFeatureMode.privatkursErwachsen:
      case SpecialFeatureMode.privatkursErwachsen2:
        return [
          StepPage.swimSeason,
          StepPage.birthDay,
          StepPage.swimPool,
          StepPage.dateSelection,
          StepPage.personalInfo,
          StepPage.result,
        ];
      default:
        return [
          StepPage.swimSchool,
          StepPage.swimLevel,
          StepPage.swimSeason,
          StepPage.birthDay,
          StepPage.swimPool,
          StepPage.swimCourse,
          StepPage.dateSelection,
          StepPage.kindPersonalInfo,
          StepPage.personalInfo,
          StepPage.result,
        ]; // default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xFF009EE1),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SwimGeneratorPage(
        graphQLClient: graphQLClient,
        title: title,
        order: order,
        swimCourseID: swimCourseID,
        isDirectLinks: isDirectLinks,
        isCodeLinks: isCodeLinks,
        code: code,
        schoolInfo: schoolInfo,
      ),
    );
  }
}
