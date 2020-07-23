import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reply/home_page.dart';
import 'package:reply/model/email_model.dart';
import 'package:reply/colors.dart';

void main() => runApp(ReplyApp());

class ReplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailModel>.value(value: EmailModel()),
      ],
      child: MaterialApp(
        title: 'Reply',
        theme: _buildReplyLightTheme(context),
        initialRoute: 'replyMain',
        onGenerateRoute: (settings) {
          if (settings.name == 'replyMain') {
            return PageRouteBuilder<void>(
              pageBuilder: (context, _, __) => HomePage(),
            );
          }
        },
      ),
    );
  }

  ThemeData _buildReplyLightTheme(BuildContext context) {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: ReplyColors.notWhite,
      canvasColor: ReplyColors.notWhite,
      accentColor: ReplyColors.orange,
      textTheme: _buildReplyTextTheme(
        GoogleFonts.workSansTextTheme(Theme.of(context).textTheme),
      ),
    );
  }

  TextTheme _buildReplyTextTheme(TextTheme base) {
    return base.copyWith(
      headline4: base.headline4.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 36,
        letterSpacing: 0.4,
        height: 0.9,
        color: ReplyColors.darkerText,
      ),
      headline5: base.headline5.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        letterSpacing: 0.27,
        color: ReplyColors.darkerText,
      ),
      headline6: base.headline6.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        letterSpacing: 0.18,
        color: ReplyColors.darkerText,
      ),
      subtitle2: base.subtitle2.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: -0.04,
        color: ReplyColors.darkText,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.2,
        color: ReplyColors.darkText,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: -0.05,
        color: ReplyColors.darkText,
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.2,
        color: ReplyColors.lightText,
      ),
    );
  }
}
