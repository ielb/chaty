import 'dart:async';

import 'package:chaty/src/extensions/extensions.dart';
import 'package:chaty/src/providers/auth_provider.dart';
import 'package:chaty/src/screens/auth/login_screen.dart';
import 'package:chaty/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _timer = Timer(const Duration(seconds: 2), () async {
        await checkAuth();
      });
    });
  }

  checkAuth() async {
    if (Provider.of<AuthProvider>(context, listen: false).token.isNotEmpty) {
      bool result =
          await Provider.of<AuthProvider>(context, listen: false).getUser();
      if (!result) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.id);
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.id);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.id);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.instance.white,
      body: Center(
        child: Config.instance.loader(),
      ),
    );
  }
}
