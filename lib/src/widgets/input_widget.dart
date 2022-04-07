import 'package:chaty/src/extensions/extensions.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.suffixIcon,
      this.obscureText = false,
      this.keyboardType = TextInputType.emailAddress,
      this.changed,
      this.validator,
      this.saved,
      this.suffix})
      : super(key: key);

  final String hint;
  final IconData suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final Function()? changed;
  final String? Function(String?)? validator;
  final Function(String?)? saved;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          hint,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Config.instance.black,
          ),
        ).align(alignment: Alignment.centerLeft).paddingOnly(left: 25),
        DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200.withOpacity(.2),
                  blurRadius: 10,
                  offset: const Offset(2, 5),
                ),
              ]),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            onFieldSubmitted: saved,
            validator: validator,
            decoration: InputDecoration(
              hintText: "Enter your " + hint.toLowerCase(),
              hintStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Config.instance.grey,
              ),
              errorStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Config.instance.red,
              ),
              prefixIcon: Icon(suffixIcon),
              suffixIcon: keyboardType == TextInputType.visiblePassword
                  ? InkWell(
                      onTap: changed,
                      child: Icon(obscureText
                          ? Icons.visibility
                          : Icons.visibility_off))
                  : suffix,
              fillColor: Config.instance.lightGrey,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Config.instance.radius),
                  borderSide: BorderSide.none),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Config.instance.radius),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Config.instance.radius),
                  borderSide: BorderSide.none),
            ),
          ),
        ).paddingSymmetric(horizontal: 20, vertical: 10),
        const SizedBox(height: 10),
      ],
    );
  }
}
