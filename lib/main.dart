import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as provider;
import 'package:reply/home_page.dart';
import 'package:reply/model/email_model.dart';
import 'package:reply/colors.dart';

void main() => runApp(ReplyApp());

class ReplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider<EmailModel>.value(value: EmailModel()),
      ],
      child: MaterialApp(
        title: 'Reply',
        theme: ThemeData(
          scaffoldBackgroundColor: ReplyColors.notWhite,
          canvasColor: ReplyColors.notWhite,
          accentColor: ReplyColors.orange,
          textTheme: GoogleFonts.workSansTextTheme(),
        ),
        initialRoute: 'replyMain',
        onGenerateRoute: (settings) {
          if (settings.name == 'replyMain') {
            return PageRouteBuilder<void>(pageBuilder: (context, _, __) => HomePage());
          }
        },
      ),
    );
  }
}
