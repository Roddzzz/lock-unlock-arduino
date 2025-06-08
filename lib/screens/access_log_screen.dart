import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_unlock_gate/domain/entities/access_log_entity.dart';
import 'package:lock_unlock_gate/domain/enums/loading_status.dart';
import 'package:lock_unlock_gate/viewmodels/access_log_screen_viewmodel.dart';
import 'package:lock_unlock_gate/viewmodels/theme_provider.dart';
import 'package:provider/provider.dart';

class AccessLogScreen extends StatelessWidget {
  const AccessLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.select((ThemeProvider t) => t.loginBox),
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
      body: buildBody(context),
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
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.arrow_back,
        color: context.select((ThemeProvider t) => t.staticColorText),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    var loadingStatus = context.select(
      (AccessLogScreenViewmodel a) => a.loadingStatus,
    );
    if (loadingStatus == LoadingStatus.LOADING) {
      return buildLoadingScreen(context);
    } else if (loadingStatus == LoadingStatus.SUCCESS) {
      return buildSuccessScreen(context);
    } else {
      return buildErrorScreen(context);
    }
  }

  Widget buildLoadingScreen(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.select((ThemeProvider t) => t.secondaryColorText),
      ),
    );
  }

  Widget buildErrorScreen(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Icon(
          Icons.error,
          color: context.select((ThemeProvider t) => t.secondaryColorText),
        ),
        Text(
          "Erro ao carregar dados...",
          style: TextStyle(
            color: context.select((ThemeProvider t) => t.secondaryColorText),
          ),
        ),
        ElevatedButton(
          onPressed: () => context.read<AccessLogScreenViewmodel>().queryLogs(),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              color: context.select((ThemeProvider t) => t.secondaryColorText),
            )
          ),
          child: Text(
            "Tentar novamente"
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }

  Widget buildSuccessScreen(BuildContext context) {
    var data = context.select((AccessLogScreenViewmodel a) => a.accessLogs);
    var themeProvider = context.select((ThemeProvider t) => t);
    return ListView.separated(
      itemCount: context.select((AccessLogScreenViewmodel a) => a.accessLogs.length),
      itemBuilder: (context, index) => buildSingleAccessLogItem(context, index, data[index], themeProvider),
      separatorBuilder:(context, index) => Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04), child: Divider(color: themeProvider.secondaryColorText,),)
    );
  }

  Widget buildSingleAccessLogItem(BuildContext context, int index, AccessLogEntity data, ThemeProvider t) {
    return ListTile(
      title: Text("Fechadura: ${data.lock.name}", style: TextStyle(color: t.secondaryColorText),),
      subtitle: Text("Usuário: ${data.user.name}\nData e horário: ${_formatTimestamp(data.timestamp)}\nID da transação: ${data.id}", style: TextStyle(color: t.secondaryColorText)),
      isThreeLine: true,
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.day}/${timestamp.month}/${timestamp.year} - ${timestamp.hour}:${timestamp.minute}";
  }
}
