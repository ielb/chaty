import 'package:chaty/src/extensions/extensions.dart';
import 'package:chaty/src/preferences/prefs.dart';
import 'package:chaty/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  String? token = await Prefs.instance.getToken();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(token)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.instance.appName,
      debugShowCheckedModeBanner: false,
      theme: Config.instance.theme(),
      initialRoute: Routes.instance.initialRoute,
      onGenerateRoute: (settings) {
        return Routes.instance.availableRoutes(settings, context);
      },
    );
  }
}
