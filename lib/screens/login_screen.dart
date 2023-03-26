import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pmsna1/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    final txtEmail = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su correo electrónico';
        }
        if (!EmailValidator.validate(value)) {
          return 'Por favor escriba un correo válido';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Correo electrónico'), border: OutlineInputBorder()),
    );
    final txtPass = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su contraseña';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Contraseña'), border: OutlineInputBorder()),
    );
    const spaceHorizontal = SizedBox(
      height: 10,
    );

    final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      onPressed: () {},
    );

    final btnFacebook = SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      onPressed: () {},
    );

    final btnGithub = SocialLoginButton(
      buttonType: SocialLoginButtonType.github,
      onPressed: () {},
    );

    final imgLogo = Image.asset(
      'assets/logo_itc.png',
      height: 200,
    );

    final txtRegister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: const Text('Crear cuenta',
            style:
                TextStyle(fontSize: 18, decoration: TextDecoration.underline)),
      ),
    );

    bool isLoading = false;

    final btnEmail = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoading = true;
        setState(() {});
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ingresando espere un momento.')),
          );
          Future.delayed(Duration(milliseconds: 4000)).then((value) {
            isLoading = false;
            setState(() {});
            if (_formKey.currentState!.validate()) {
              Navigator.pushNamed(context, '/dash');
            }
          });
        }
      },
    );

    return Scaffold(
        body: Responsive(
      mobile: MobileLogin(
          formKey: _formKey,
          imgLogo: imgLogo,
          txtEmail: txtEmail,
          spaceHorizontal: spaceHorizontal,
          txtPass: txtPass,
          btnEmail: btnEmail,
          btnGoogle: btnGoogle,
          btnFacebook: btnFacebook,
          btnGithub: btnGithub,
          txtRegister: txtRegister),
      desktop: DesktopLogin(
          formKey: _formKey,
          imgLogo: imgLogo,
          txtEmail: txtEmail,
          spaceHorizontal: spaceHorizontal,
          txtPass: txtPass,
          btnEmail: btnEmail,
          btnGoogle: btnGoogle,
          btnFacebook: btnFacebook,
          btnGithub: btnGithub,
          txtRegister: txtRegister),
    ));
  }
}

class MobileLogin extends StatelessWidget {
  const MobileLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.imgLogo,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnEmail,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btnGithub,
    required this.txtRegister,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final Image imgLogo;
  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnEmail;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: .4,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/fondo_itc.jpg'))),
          child: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  width: 400,
                  child: Column(
                    children: <Widget>[
                      imgLogo,
                      txtEmail,
                      spaceHorizontal,
                      txtPass,
                      spaceHorizontal,
                      btnEmail,
                      spaceHorizontal,
                      btnGoogle,
                      spaceHorizontal,
                      btnFacebook,
                      spaceHorizontal,
                      btnGithub,
                      txtRegister,
                      spaceHorizontal,
                    ],
                  ),
                ),
              )),
        )
      ],
    );
  }
}

class DesktopLogin extends StatelessWidget {
  const DesktopLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.imgLogo,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnEmail,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btnGithub,
    required this.txtRegister,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final Image imgLogo;
  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnEmail;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: .4,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/fondo_itc.jpg'))),
          child: Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: imgLogo,
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 500,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              txtEmail,
                              spaceHorizontal,
                              txtPass,
                              spaceHorizontal,
                              btnEmail,
                              spaceHorizontal,
                              btnGoogle,
                              spaceHorizontal,
                              btnFacebook,
                              spaceHorizontal,
                              btnGithub,
                              txtRegister,
                              spaceHorizontal,
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                  )
                ],
              )),
        )
      ],
    );
  }
}
