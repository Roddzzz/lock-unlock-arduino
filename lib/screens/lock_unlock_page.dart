import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/models/app_colors.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isLocked = true; // Estado do icone de cadeado
  bool _isLoading = false; // Estado do loader
  bool _isDarkMode = false; // Estado do darkmode

  /*void _showSnackbar(String message, bool success) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 70, // Posição no topo da tela
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: success ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 5),
              ],
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Remove o popup após 2 segundos
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  } */
  void _showSnackbar(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(color: AppColors.primaryTextColor, fontWeight: FontWeight.w600, fontSize: 14),
      ),
      backgroundColor: success ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _toggleLock() async {
    setState(() {
      _isLoading = true;
    });

    // Simula uma chamada de API
    await Future.delayed(Duration(seconds: 2));

    // Simula sucesso ou falha na operação
    bool success = false; // Altere para `false` para testar a falha

    setState(() {
      _isLoading = false;
      if (success) {
        isLocked = !isLocked;
        _showSnackbar(
          isLocked ? "Bloqueado com sucesso!" : "Desbloqueado com sucesso!",
          true,
        );
      } else {
        _showSnackbar("Falha ao realizar a ação!", false);
      }
    });
  }

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.staticColorText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Garen Ga042",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColorText,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap:
              _isLoading
                  ? null
                  : _toggleLock, //Desabilita o clique enquanto carrega.
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
                      color: AppColors.primaryTextColor,
                    ),
                  ) // Loader
                      : Icon(
                    isLocked ? Icons.lock_outline : Icons.lock_open,
                    key: ValueKey<bool>(isLocked),
                    color: AppColors.primaryTextColor,
                    size: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Toque para desbloquear ou bloquear",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(fontSize: 14, color: AppColors.secondaryColorText),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
