import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/domain/enums/loading_status.dart';
import 'package:lock_unlock_gate/viewmodels/hub_screen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:lock_unlock_gate/viewmodels/theme_provider.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

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
        leading: buildDrawerMenuIcon(context),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 9.0),
            child: IconButton(
              icon: _buildDarkModeIcon(context),
              onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: context.select((ThemeProvider t) => t.staticColorText),
            ),
            onPressed: () => _showExitDialog(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: buildDrawerItems(context),
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
              children: _buildPageBody(context),
            ),
          ),
        ),
      ),
      backgroundColor: context.select((ThemeProvider t) => t.backgroundColor),
    );
  }

  List<Widget> _buildPageBody(BuildContext context) {
    final status = context.select(
      (HubScreenViewmodel v) => v.locksLoadingStatus,
    );
    if (status == LoadingStatus.SUCCESS) {
      return _buildLockContainerList(context);
    } else if (status == LoadingStatus.LOADING) {
      return [CircularProgressIndicator()];
    }
    return _buildErrorPageBody(context);
  }

  List<Widget> _buildLockContainerList(BuildContext context) {
    final List<LockEntity> locks = context.select(
      (HubScreenViewmodel h) => h.locks,
    );
    List<Widget> containers = [];
    containers.addAll(locks.map((l) => _buildSingleLockContainer(context, l)));
    containers.add(_buildAddLocksContainer(context));
    return containers;
  }

  Widget _buildAddLocksContainer(BuildContext context) {
    return Container(
      width: 155,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        color: context.select((ThemeProvider t) => t.loginBox),
      ),
      child: Center(
        child: Icon(
          Icons.add,
          size: 30,
          color: context.select((ThemeProvider t) => t.secondaryColorText),
        ),
      ),
    );
  }

  Widget _buildSingleLockContainer(BuildContext context, LockEntity lock) {
    return SizedBox(
      width: 155,
      height: 155,
      child: ElevatedButton(
        onPressed: () => _viewSingleLock(context, lock),
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.transparent,
          backgroundColor: context.select((ThemeProvider t) => t.loginBox),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          padding: EdgeInsets.zero,
          // Remove padding interno extra
          elevation: 0, // Sem sombra, igual ao Container
        ),
        child: Center(
          child: Text(
            lock.name,
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: context.select((ThemeProvider t) => t.secondaryColorText),
            ),
          ),
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext innerContext) {
        final provider = Provider.of<ThemeProvider>(context);
        return AlertDialog(
          backgroundColor: provider.loginBox,
          title: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Deseja sair?",
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: provider.secondaryColorText,
              ),
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
                      color: provider.secondaryColorText,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).popAndPushNamed('/loginScreen');
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

  Widget _buildDarkModeIcon(BuildContext context) {
    final (isDarkMode, staticColorText) = context.select(
      (ThemeProvider t) => (t.isDarkMode, t.staticColorText),
    );
    return Icon(
      isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
      color: staticColorText,
    );
  }

  List<Widget> _buildErrorPageBody(BuildContext context) {
    return [
      Text("Erro ao carregar informações! Por favor tente novamente"),
      ElevatedButton(
        onPressed: () => context.read<HubScreenViewmodel>().queryLocks(),
        child: Text("Tentar novamente"),
      ),
    ];
  }

  void _viewSingleLock(BuildContext context, LockEntity lock) {
    context.read<HubScreenViewmodel>().setViewingLock(lock);
    Navigator.pushNamed(context, '/lockUnlockScreen', arguments: lock);
  }

  Widget buildDrawerMenuIcon(BuildContext context) {
    Color c = context.select((ThemeProvider t) => t.staticColorText);
    return Builder(
      builder:
          (innerctx) => IconButton(
            onPressed: () => Scaffold.of(innerctx).openDrawer(),
            icon: Icon(Icons.menu, color: c),
          ),
    );
  }
  
  Widget buildDrawerItem(int index, ThemeProvider t, BuildContext context) {
    switch (index) {
      case 0:
        return DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: t.backgroundColor,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: t.secondaryColorText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
      case 1:
        return ListTile(
              tileColor: t.loginBox,
              title: Text(
                "Logs de acesso",
                style: TextStyle(
                  color: t.secondaryColorText,
                ),
              ),
              onTap: () => Navigator.of(context).pushNamed('/accessLogScreen'),
            );
      default:
        return SizedBox();
    }
  }
  
  Widget buildDrawerItems(BuildContext context) {
    ThemeProvider t = context.watch<ThemeProvider>();
    return ListView.separated(
          itemCount: 2,
          padding: EdgeInsets.zero,
          separatorBuilder: (innerContext, index) => Divider(height: 0, thickness: 0, color: Colors.transparent,),
          itemBuilder: (innerContext, index) => buildDrawerItem(index, t, innerContext),
        );
  }
}
