import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/app_routes.dart';
import 'package:lock_unlock_gate/models/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    AppColors.darkMode(_isDarkMode);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "Lock Unlock Arduino",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: AppColors.staticColorText,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 9.0),
            child: IconButton(
              icon: Icon(
                _isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: AppColors.staticColorText,
              ),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ),
        ],
        /* shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.only(
             bottomLeft: Radius.circular(14.0),
             bottomRight: Radius.circular(14.0),
           ),
         ),*/
        //Bordas arrendondas na appbar
      ),
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            color: AppColors.loginBox,
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80), // Padding superior
                child: Text(
                  'Login',
                  style: GoogleFonts.nunito(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColorText,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 50), // Padding em cima e embaixo
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 35), // Padding em cima e embaixo
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 60), // Padding em cima e embaixo
                child: SizedBox(
                  height: 48,
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.lockUnlockPage);
                    },
                    child: Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Cor de fundo
                      backgroundColor: AppColors.appBarColor, // Cor do texto
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
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
