import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/viewmodels/login_screen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/models/theme_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final FocusNode _userFocusNode = FocusNode();
  final TextEditingController _userTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.select(
          (ThemeProvider t) => t.appColors.appBarColor,
        ),
        title: Text(
          "Lock Unlock Arduino",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: context.select(
              (ThemeProvider t) => t.appColors.staticColorText,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 9.0),
            child: IconButton(
              icon: _buildDarkModeIcon(context),
              onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 370,
          height: 550,
          decoration: BoxDecoration(
            color: context.select((ThemeProvider t) => t.appColors.loginBox),
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
                    color: context.select(
                      (ThemeProvider t) => t.appColors.secondaryColorText,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 65),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    onSubmitted:
                        (_) =>
                            _handleLoginValidation(context),
                    autofocus: true,
                    focusNode: _userFocusNode,
                    controller: _userTextController,
                    cursorColor: context.select(
                      (ThemeProvider t) => t.appColors.appBarColor,
                    ),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: context.select(
                        (ThemeProvider t) => t.appColors.secondaryColorText,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        color: context.select(
                          (ThemeProvider t) => t.appColors.secondaryColorText,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.appColors.secondaryColorText,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.appColors.appBarColor,
                          ),
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
                    onSubmitted:
                        (_) =>
                            _handleLoginValidation(context),
                    controller: _passwordTextController,
                    obscureText: context.select(
                      (LoginScreenViewmodel l) => l.passwordFieldObscureText,
                    ),
                    cursorColor: context.select(
                      (ThemeProvider t) => t.appColors.appBarColor,
                    ),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: context.select(
                        (ThemeProvider t) => t.appColors.secondaryColorText,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        color: context.select(
                          (ThemeProvider t) => t.appColors.secondaryColorText,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Builder(
                          builder: (BuildContext builderBuildContext) {
                            final bool isObscureText = builderBuildContext
                                .select(
                                  (LoginScreenViewmodel l) =>
                                      l.passwordFieldObscureText,
                                );
                            final Color color = builderBuildContext.select(
                              (ThemeProvider t) =>
                                  t.appColors.secondaryColorText,
                            );
                            return Icon(
                              isObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility_outlined,
                              color: color,
                              size: 19,
                            );
                          },
                        ),
                        onPressed: () => context.read<LoginScreenViewmodel>().toggleObscurePassword(),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.appColors.secondaryColorText,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.appColors.appBarColor,
                          ),
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
                        color: context.select(
                          (ThemeProvider t) => t.appColors.appBarColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      'Registrar-se',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: context.select(
                          (ThemeProvider t) => t.appColors.appBarColor,
                        ),
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
                    onPressed: () => _handleLoginValidation(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Cor de fundo
                      backgroundColor: context.select(
                        (ThemeProvider t) => t.appColors.appBarColor,
                      ), // Cor do texto
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Entrar',
                      style: GoogleFonts.nunito(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: context.select(
        (ThemeProvider t) => t.appColors.backgroundColor,
      ),
    );
  }

  void _handleLoginValidation(BuildContext context) async {
    final String username = _userTextController.text.trim();
    final String password = _passwordTextController.text.trim();
    if(username == "" || password == "") {
      _showSnackbarInvalidLogin(context, 'Preencha todos os campos obrigatórios para Login');
      return;
    }
    final success = await context.read<LoginScreenViewmodel>().validateLogin(username, password);
    if(success) {
      if(context.mounted) {
        await Navigator.of(context).pushNamed('/hubManagementScreen');
        _userTextController.dispose();
        _passwordTextController.dispose();
        _userFocusNode.dispose();
        return;
      }
    }
    if(context.mounted) {
      _showSnackbarInvalidLogin(context, 'Usuário e/ou senha incorretos!');
      _userTextController.clear();
      _passwordTextController.clear();
      _userFocusNode.requestFocus();
    }
  }
  
  Widget _buildDarkModeIcon(BuildContext context) {
    final (darkMode, staticColorText) = context.select(
      (ThemeProvider t) => (
        t.isDarkMode,
        t.appColors.staticColorText,
      ),
    );
    return Icon(
      darkMode
          ? Icons.light_mode_outlined
          : Icons.dark_mode_outlined,
      color: staticColorText,
    );
  }
}

//   @override
//   void dispose() {
//     _focusNodeUser.dispose();
//     _controllerPassword.dispose();
//     super.dispose();
//   }

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
// }
