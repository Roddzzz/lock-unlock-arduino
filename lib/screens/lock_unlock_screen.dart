import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/models/theme_provider.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isLocked = true; // Estado do cadeado
  bool _isLoading = false; // Estado do loader

  void _showSnackbar(BuildContext context, String message, bool success) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color: Provider.of<ThemeProvider>(context, listen: false)
              .appColors
              .staticColorText,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      backgroundColor: success ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _toggleLock(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    bool success = true; // Altere para `false` para testar falha

    setState(() {
      _isLoading = false;
      if (success) {
        isLocked = !isLocked;
        _showSnackbar(context,
            isLocked ? "Bloqueado com sucesso!" : "Desbloqueado com sucesso!", true);
      } else {
        _showSnackbar(context, "Falha ao realizar a ação!", false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.staticColorText),
          onPressed: () => Navigator.pop(context),
        ),
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
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Garen Ga042",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appColors.secondaryColorText,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _isLoading ? null : () => _toggleLock(context),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLocked ? Colors.red : Colors.green,
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: _isLoading
                      ? Center(
                    child: CircularProgressIndicator(
                      color: appColors.primaryTextColor,
                    ),
                  )
                      : Icon(
                    isLocked ? Icons.lock_outline : Icons.lock_open,
                    key: ValueKey<bool>(isLocked),
                    color: appColors.primaryTextColor,
                    size: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Toque para desbloquear ou bloquear",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 14,
                color: appColors.secondaryColorText,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: appColors.backgroundColor,
    );
  }
}
