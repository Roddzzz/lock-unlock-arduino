import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/app_routes.dart';
import 'package:provider/provider.dart';  // Importando o Provider
import 'package:lock_unlock_gate/models/theme_provider.dart';  // Importe o ThemeProvider

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Acesse o tema atual do Provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Aplique as cores com base no tema atual
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
                isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
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
                    obscureText: true,
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
                          Icons.visibility_off,
                          color: appColors.secondaryColorText,
                          size: 19,
                        ),
                        onPressed: () {},
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
                      Navigator.pushNamed(context, AppRoutes.lockUnlockPage);
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
