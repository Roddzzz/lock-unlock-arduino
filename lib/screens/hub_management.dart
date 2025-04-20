import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/viewmodels/theme_provider.dart';

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final provider = Provider.of<ThemeProvider>(context);
        return AlertDialog(
          backgroundColor: provider.loginBox,
          title: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Deseja sair?",
              style: GoogleFonts.nunito(fontSize: 16, color: provider.secondaryColorText),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Fecha o popup
                  child: Text(
                    "Cancelar",
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: provider.secondaryColorText
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Fecha o popup
                    Navigator.pop(context); // Sai da tela
                  },
                  child: Text(
                    "Sair",
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.appBarColor,
        title: Text(
          "Lock Unlock Arduino",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: themeProvider.staticColorText,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeProvider.staticColorText),
          onPressed: () => _showExitDialog(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 9.0),
            child: IconButton(
              icon: Icon(
                themeProvider.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: themeProvider.staticColorText,
              ),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 550,
            height: 200,
            child: Wrap(
              spacing: 40, // Espaço horizontal entre os containers
              runSpacing: 20, // Espaço vertical entre as linhas
              alignment: WrapAlignment.center, // Centraliza horizontalmente
              children: [
                SizedBox(
                  width: 155,
                  height: 155,
                  child: ElevatedButton(
                    onPressed:
                        () => Navigator.pushNamed(context, 'lockUnlockScreen'),
                    style: ElevatedButton.styleFrom(
                      overlayColor: Colors.transparent,
                      backgroundColor: themeProvider.loginBox,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      padding: EdgeInsets.zero,
                      // Remove padding interno extra
                      elevation: 0, // Sem sombra, igual ao Container
                    ),
                    child: Center(
                      child: Text(
                        'Ga042',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: themeProvider.secondaryColorText,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 155,
                  height: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    color: themeProvider.loginBox,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: themeProvider.secondaryColorText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: themeProvider.backgroundColor,
    );
  }
}
