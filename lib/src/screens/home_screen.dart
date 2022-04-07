import 'package:chaty/src/extensions/extensions.dart';
import 'package:chaty/src/preferences/prefs.dart';
import 'package:chaty/src/screens/auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.instance.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Home"),
      ),
      body: Center(
        child: InkWell(
            onTap: () async {
              await Prefs.instance.clearToken();
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.id,
                (route) => false,
              );
            },
            child: const Text("Home Screen")),
      ),
    );
  }
}
