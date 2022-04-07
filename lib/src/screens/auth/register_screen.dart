import 'package:chaty/src/extensions/extensions.dart';
import 'package:chaty/src/providers/auth_provider.dart';
import 'package:chaty/src/screens/home_screen.dart';
import 'package:chaty/src/widgets/input_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const id = "register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordObsecure = true;
  final _formKey = GlobalKey<FormState>();
  bool? exist;

  register() async {
    bool result = await Provider.of<AuthProvider>(context, listen: false)
        .register(_nameController.text, _emailController.text,
            _passwordController.text);
    if (result) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.id, (route) => true);
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> checkName() async {
    exist = await Provider.of<AuthProvider>(context, listen: false)
        .checkName(_nameController.text);
    setState(() {});
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
                  "Register",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Config.instance.black,
                  ),
                ).align(alignment: Alignment.centerLeft).paddingOnly(left: 30),
                const SizedBox(height: 50),
                InputWidget(
                  controller: _nameController,
                  hint: "Name",
                  suffixIcon: Ionicons.person_outline,
                  keyboardType: TextInputType.text,
                  suffix: exist == null
                      ? null
                      : exist!
                          ? const Icon(Ionicons.checkmark_circle_outline,
                              color: Colors.greenAccent)
                          : const Icon(Ionicons.close_circle_outline,
                              color: Colors.redAccent),
                  saved: (name) async {
                    if (name != null && name.isNotEmpty) {
                      checkName();
                    }
                  },
                  validator: (name) {
                    if (name != null && name.isNotEmpty) {
                      if (name.length < 4) {
                        return "name must be at least 4 characters";
                      } else {
                        if (exist == null) {
                          return null;
                        } else {
                          return exist! ? null : "name already exist";
                        }
                      }
                    } else {
                      return "Please enter your name";
                    }
                  },
                ),
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
                  onPressed: () async {
                    if (_nameController.text.isNotEmpty) {
                      if (_nameController.text.length > 4) {
                        await checkName();
                      }
                    }
                    if (_formKey.currentState!.validate()) {
                      Config.instance.loading(context);
                      register();
                    }
                  },
                  child: Text(
                    "Register",
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
                      "Aleady have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Config.instance.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
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
