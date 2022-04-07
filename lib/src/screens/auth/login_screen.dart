import 'package:chaty/src/extensions/extensions.dart';
import 'package:chaty/src/providers/auth_provider.dart';
import 'package:chaty/src/screens/auth/register_screen.dart';
import 'package:chaty/src/screens/home_screen.dart';
import 'package:chaty/src/widgets/input_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _passwordObsecure = true;
  late AuthProvider _auth;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _auth = Provider.of<AuthProvider>(context, listen: false);
    });
  }

  login() async {
    bool result =
        await _auth.login(_emailController.text, _passwordController.text);
    if (result) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.id, (route) => true);
    } else {
      Config.instance.showErrorDialog(context, _auth.error);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.instance.white,
      body: SizedBox(
        height: screenSize(context).height,
        width: screenSize(context).width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text.rich(
                  TextSpan(
                    text: "Welcome to ",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Config.instance.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Chaty",
                        style: GoogleFonts.pacifico(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Config.instance.primary,
                        ),
                      ),
                      TextSpan(
                        text: "\b.\n",
                        style: GoogleFonts.pacifico(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Config.instance.black,
                        ),
                      ),
                    ],
                  ),
                ).align(alignment: Alignment.centerLeft).paddingOnly(left: 20),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Config.instance.black,
                  ),
                ).align(alignment: Alignment.centerLeft).paddingOnly(left: 30),
                const SizedBox(height: 50),
                InputWidget(
                  hint: "Email",
                  controller: _emailController,
                  suffixIcon: Ionicons.mail_outline,
                  validator: (email) {
                    if (email != null && email.isNotEmpty) {
                      if (!email.isEmail()) {
                        return "Please enter a valid email";
                      }
                    } else {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                InputWidget(
                  hint: "Password",
                  controller: _passwordController,
                  suffixIcon: Ionicons.lock_closed_outline,
                  obscureText: _passwordObsecure,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (password) {
                    if (password != null && password.isNotEmpty) {
                      if (password.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                    } else {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  changed: () {
                    setState(() {
                      _passwordObsecure = !_passwordObsecure;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Config.instance.black,
                    ),
                  )
                      .align(alignment: Alignment.centerRight)
                      .paddingOnly(right: 25),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenSize(context).width * .9, 40),
                    primary: Config.instance.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                  ),
                  onPressed: () {
                    // un focus
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Config.instance.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Config.instance.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Config.instance.primary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
