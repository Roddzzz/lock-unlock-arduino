import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/models/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscureText = true;
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final FocusNode _focusNodeUser = FocusNode();

  void _validateLogin() {
    if (_controllerUser.text.trim() != "" && _controllerPassword.text != "") {
      if (_controllerUser.text.trim() == "admin" &&
          _controllerPassword.text == "admin") {
        Navigator.pushNamed(context, AppRoutes.lockUnlockScreen);
        _controllerUser.clear();
        _controllerPassword.clear();
      } else {
        setState(() {
          _showSnackbarInvalidLogin(context, "Usuário ou senha incorretos");
        });
        _controllerUser.clear();
        _controllerPassword.clear();
        _focusNodeUser.requestFocus();
      }
    } else {
      setState(() {
        _showSnackbarInvalidLogin(
          context,
          "Preencha todos os campos obrigatórios para Login",
        );
      });
    }
  }

  @override
  void dispose() {
    _focusNodeUser.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void _showSnackbarInvalidLogin(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color:
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).appColors.staticColorText,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // Acesse o tema atual do Provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    final appColors = themeProvider.appColors;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.appBarColor,
        title: Text(
          "Lock Unlock Arduino",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: appColors.staticColorText,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 9.0),
            child: IconButton(
              icon: Icon(
                themeProvider.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: appColors.staticColorText,
              ),
              onPressed: () {
                // Alternar o tema ao clicar no botão
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 370,
          height: 550,
          decoration: BoxDecoration(
            color: appColors.loginBox,
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 65), // Padding superior
                child: Text(
                  'Login',
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: appColors.secondaryColorText,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 65),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    onSubmitted: (_) => {_validateLogin()},
                    autofocus: true,
                    focusNode: _focusNodeUser,
                    controller: _controllerUser,
                    cursorColor: appColors.appBarColor,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: appColors.secondaryColorText,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        color: appColors.secondaryColorText,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: appColors.secondaryColorText,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: appColors.appBarColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    onSubmitted: (_) => _validateLogin(),
                    controller: _controllerPassword,
                    obscureText: _isObscureText,
                    cursorColor: appColors.appBarColor,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: appColors.secondaryColorText,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        color: appColors.secondaryColorText,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscureText
                              ? Icons.visibility_off
                              : Icons.visibility_outlined,
                          color: appColors.secondaryColorText,
                          size: 19,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscureText = !_isObscureText;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: appColors.secondaryColorText,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: appColors.appBarColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20), // Padding superior
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Esqueci minha senha',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: appColors.appBarColor,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      'Registrar-se',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: appColors.appBarColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 85), // Padding em cima e embaixo
                child: SizedBox(
                  height: 48,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      _validateLogin();
                    },
                    child: Text(
                      'Entrar',
                      style: GoogleFonts.nunito(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Cor de fundo
                      backgroundColor: appColors.appBarColor, // Cor do texto
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: appColors.backgroundColor,
    );
  }
}
