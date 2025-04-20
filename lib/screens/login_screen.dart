import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/viewmodels/login_screen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/viewmodels/theme_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final FocusNode _userFocusNode = FocusNode();
  final TextEditingController _userTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  Widget?
  _loginButtonWidget; // Inicializado tardiamente pois aqui ficam as animações do botão de login enquanto espera resposta da API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.select(
          (ThemeProvider t) => t.appBarColor,
        ),
        title: Text(
          "Lock Unlock Arduino",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: context.select(
              (ThemeProvider t) => t.staticColorText,
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
            color: context.select((ThemeProvider t) => t.loginBox),
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
                      (ThemeProvider t) => t.secondaryColorText,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 65),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    onSubmitted: (_) => _handleLoginValidation(context),
                    autofocus: true,
                    focusNode: _userFocusNode,
                    controller: _userTextController,
                    cursorColor: context.select(
                      (ThemeProvider t) => t.appBarColor,
                    ),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: context.select(
                        (ThemeProvider t) => t.secondaryColorText,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        color: context.select(
                          (ThemeProvider t) => t.secondaryColorText,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.secondaryColorText,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.appBarColor,
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
                    onSubmitted: (_) => _handleLoginValidation(context),
                    controller: _passwordTextController,
                    obscureText: context.select(
                      (LoginScreenViewmodel l) => l.passwordFieldObscureText,
                    ),
                    cursorColor: context.select(
                      (ThemeProvider t) => t.appBarColor,
                    ),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: context.select(
                        (ThemeProvider t) => t.secondaryColorText,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        color: context.select(
                          (ThemeProvider t) => t.secondaryColorText,
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
                                  t.secondaryColorText,
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
                        onPressed:
                            () =>
                                context
                                    .read<LoginScreenViewmodel>()
                                    .toggleObscurePassword(),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.secondaryColorText,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: context.select(
                            (ThemeProvider t) => t.appBarColor,
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
                          (ThemeProvider t) => t.appBarColor,
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
                          (ThemeProvider t) => t.appBarColor,
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
                  child: AnimatedSwitcher(duration: const Duration(milliseconds: 300), transitionBuilder: (Widget w, Animation<double> a) => ScaleTransition(scale: a, child: w), child: _buildAndInitializeLoginButton(context)),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: context.select(
        (ThemeProvider t) => t.backgroundColor,
      ),
    );
  }

  void _handleLoginValidation(BuildContext context) async {
    final String username = _userTextController.text.trim();
    final String password = _passwordTextController.text.trim();
    if (username == "" || password == "") {
      _showSnackbarInvalidLogin(
        context,
        'Preencha todos os campos obrigatórios para Login',
      );
      return;
    }
    final success = await context.read<LoginScreenViewmodel>().validateLogin(
      username,
      password,
    );
    if (success) {
      if (context.mounted) {
        await Navigator.of(context).popAndPushNamed('/hubManagementScreen');
        _userTextController.dispose();
        _passwordTextController.dispose();
        _userFocusNode.dispose();
        return;
      }
    }
    if (context.mounted) {
      _showSnackbarInvalidLogin(context, 'Usuário e/ou senha incorretos!');
      _userTextController.clear();
      _passwordTextController.clear();
      _userFocusNode.requestFocus();
    }
  }

  Widget _buildDarkModeIcon(BuildContext context) {
    final (darkMode, staticColorText) = context.select(
      (ThemeProvider t) => (t.isDarkMode, t.staticColorText),
    );
    return Icon(
      darkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
      color: staticColorText,
    );
  }

  Widget _buildAndInitializeLoginButton(BuildContext context) {
    final bool loginButtonLoading = context.select(
      (LoginScreenViewmodel l) => l.loginButtonLoading,
    );
    if (loginButtonLoading) {
      _loginButtonWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator()
        ],
      );
    } else {
      _loginButtonWidget = ElevatedButton(
        onPressed: () => _handleLoginValidation(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // Cor de fundo
          backgroundColor: context.select(
            (ThemeProvider t) => t.appBarColor,
          ), // Cor do texto
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text('Entrar', style: GoogleFonts.nunito(fontSize: 16)),
      );
    }
    return _loginButtonWidget!;
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
            ).staticColorText,
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
