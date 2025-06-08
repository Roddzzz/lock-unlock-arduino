import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/viewmodels/theme_provider.dart';
import 'package:provider/provider.dart';

class AccessLogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.select((ThemeProvider t) => t.appBarColor),
        title: Text(
          "Logs de acesso",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: context.select((ThemeProvider t) => t.staticColorText),
          ),
        ),
        centerTitle: true,
        leading: _buildBackArrowButton(context),
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
    );
  }

  Widget _buildDarkModeIcon(BuildContext context) {
    final (isDarkMode, staticColorText) = context.select(
      (ThemeProvider t) => (t.isDarkMode, t.staticColorText),
    );
    return Icon(
      isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
      color: staticColorText,
    );
  }
  
  Widget _buildBackArrowButton(BuildContext context) {
    return IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back, color: context.select((ThemeProvider t) => t.staticColorText),));
  }
}