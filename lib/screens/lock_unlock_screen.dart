import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/viewmodels/theme_provider.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isLocked = true;
  bool _isLoading = false;
  bool _isCooldown = false; // Estado de "esperando 10s"

  void _showSnackbar(BuildContext context, String message, bool success) {
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
      backgroundColor: success ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _unlockGate(BuildContext context) async {
    if (!isLocked || _isLoading || _isCooldown) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    bool success = true; //Retorno API

    if (success) {
      setState(() {
        isLocked = false;
        _isLoading = false;
        _isCooldown = true;
      });

      _showSnackbar(context, "Desbloqueado com sucesso!", true);

      await Future.delayed(Duration(seconds: 10));

      setState(() {
        isLocked = true;
        _isCooldown = false;
      });

      _showSnackbar(context, "Tranca foi fechada automaticamente.", true);
    } else {
      setState(() {
        _isLoading = false;
      });
      _showSnackbar(context, "Falha ao desbloquear!", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final arguments = ModalRoute.of(context)!.settings.arguments as LockEntity;
    print(arguments);

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
                color: themeProvider.staticColorText,
              ),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      backgroundColor: themeProvider.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Garen Ga042",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeProvider.secondaryColorText,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _unlockGate(context),
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
                  child:
                      _isLoading
                          ? Center(
                            child: CircularProgressIndicator(
                              color: themeProvider.primaryTextColor,
                            ),
                          )
                          : Icon(
                            isLocked ? Icons.lock_outline : Icons.lock_open,
                            key: ValueKey<bool>(isLocked),
                            color: themeProvider.primaryTextColor,
                            size: 50,
                          ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _isCooldown ? "Tranca ainda aberta..." : "Toque para destrancar",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 14,
                color: themeProvider.secondaryColorText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
