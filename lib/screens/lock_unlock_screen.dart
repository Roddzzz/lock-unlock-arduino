import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/domain/enums/loading_status.dart';
import 'package:lock_unlock_gate/viewmodels/lock_screen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/viewmodels/theme_provider.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.select((ThemeProvider t) => t.appBarColor),
        title: Text(
          "Lock Unlock Arduino",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: context.select((ThemeProvider t) => t.staticColorText),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.select((ThemeProvider t) => t.staticColorText),
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
      backgroundColor: context.select((ThemeProvider t) => t.backgroundColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Garen Ga042",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.select(
                  (ThemeProvider t) => t.secondaryColorText,
                ),
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
                  color:
                      context.select((LockScreenViewmodel l) => l.locked)
                          ? Colors.red
                          : Colors.green,
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: _buildLockUnlockTransition(context),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              context.select(
                    (LockScreenViewmodel l) =>
                        l.loadingStatus == LoadingStatus.SUCCESS,
                  )
                  ? "Tranca ainda aberta..."
                  : "Toque para destrancar",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 14,
                color: context.select(
                  (ThemeProvider t) => t.secondaryColorText,
                ),
              ),
            ),
          ],
        ),
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

  Future<void> _unlockGate(BuildContext context) async {
    final success = await context.read<LockScreenViewmodel>().unlock();
    if (success && context.mounted) {
      _showSnackbar(context, "Desbloqueado com sucesso!", success);
    } else if (!success && context.mounted) {
      _showSnackbar(context, "Falha ao desbloquear!", success);
    }
  }

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

  Widget _buildLockUnlockTransition(BuildContext context) {
    final (loadingStatus, locked) = context.select(
      (LockScreenViewmodel l) => (l.loadingStatus, l.locked),
    );
    if (loadingStatus == LoadingStatus.LOADING) {
      return Center(
        child: CircularProgressIndicator(
          color: context.select((ThemeProvider t) => t.primaryTextColor),
        ),
      );
    } else if (loadingStatus == LoadingStatus.SUCCESS ||
        loadingStatus == LoadingStatus.NOT_DIRTY) {
      return Icon(
        locked ? Icons.lock_outline : Icons.lock_open,
        key: ValueKey<bool>(locked),
        color: context.select((ThemeProvider t) => t.primaryTextColor),
        size: 50,
      );
    }
    return Icon(
      Icons.error,
      key: Key("ERROR_STATE"),
      color: context.select((ThemeProvider t) => t.primaryTextColor),
      size: 50,
    );
  }
}

// class _LockScreenState extends State<LockScreen> {
//   bool isLocked = true;
//   bool _isLoading = false;
//   bool _isCooldown = false; // Estado de "esperando 10s"



//   Future<void> _unlockGate(BuildContext context) async {
//     if (!isLocked || _isLoading || _isCooldown) return;

//     setState(() {
//       _isLoading = true;
//     });

//     await Future.delayed(Duration(seconds: 2));

//     bool success = true; //Retorno API

//     if (success) {
//       setState(() {
//         isLocked = false;
//         _isLoading = false;
//         _isCooldown = true;
//       });


//       await Future.delayed(Duration(seconds: 10));

//       setState(() {
//         isLocked = true;
//         _isCooldown = false;
//       });

//       _showSnackbar(context, "Tranca foi fechada automaticamente.", true);
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       _showSnackbar(context, "Falha ao desbloquear!", false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final arguments = ModalRoute.of(context)!.settings.arguments as LockEntity;
//     print(arguments);


//   }
// }
